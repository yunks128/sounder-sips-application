Unity Sounder SIPS Application
==============================

This repository represents the containerization of the Sounder SIPS `SPSS <https://github.jpl.nasa.gov/SIPS/SPSS>`_ repository into a Unity Application Package.

Requirements
------------

In order to use this repository you will need access to the `Sounder SIPS Github Organization <https://github.jpl.nasa.gov/SIPS/>`_ on the JPL Enterprise server. This repository pulls in this repository as a Git submodule. The Git LFS module must be installed in order for binary files to be correctly download. Additionally you will need access to Docker and Docker Compose. See the **Static Files** section for information on obtaining the necessary static files.

Building
--------

The following steps will prepare the repository for usage::

    # Check out repository
    $ git clone git@github.jpl.nasa.gov:unity-sds/sips_spss_build.git
    $ cd sips_spss_build

    # Initialize Sounder SIPS SPSS repository
    $ git submodule init
    $ git submodule update

Then to build the Docker images run the following::

    # Build docker images
    $ docker-compose build

After the Docker build process you should have 4 Docker images available:

* unity-sds/sounder_sips_base
* unity-sds/sounder_sips_pge_common
* unity-sds/sounder_sips_l1a_pge
* unity-sds/sounder_sips_l1b_pge

The Docker images will all share a common tag representing their version number. The first two images are an artifact of the build process, they will not be used in PGE execution. The second two images are used for PGE execution.

Static Files
-------------

A set of large static files is needed for running the SIPS algorithms. These files can be obtain in one of several ways:

From the Sounder SIPS Machines
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Log into the Sounder SIPS machine ``smog`` and copy the following directories to the machine that will run your built Docker image::

    $ ssh smog
    $ scp -r /peate/support/static/dem my_machine:dem
    $ scp -r /ref/devstable/STORE/mcf my_machine:mcf

From the MIPL HPC Machine
~~~~~~~~~~~~~~~~~~~~~~~~~

These files are also staged on the Section 398 MIPL HPC machine at ``miplhpc1:/export/proj1/home/mcduffie/unity/static_files``.

From S3
~~~~~~~

These files are additionally stored with in the following Unity S3 bucket: ``s3://unity-ads/sounder_sips/static_files``.

Staging
~~~~~~~

These two directories will need to be staged within the Docker image through volume mounts as described in subsequent sections. 

Direct Usage
------------

The PGE Docker images requires several paths to be available to the container through volume mounts. The default paths are:

* ``/pge/in`` - Where input L0 input files are located
* ``/pge/out`` - Where output files will be written
* ``/data/static`` - Path where the static ``dem`` and ``mcf`` directories are located.

These defaults can be overridden with the following parameters:

* input_path
* output_path
* data_static_path

`Papermill <https://papermill.readthedocs.io/>`_ is used as an interface to the `Jupyter <https://jupyter.org/>`_ notebook that wraps the L1A and L1B PGE executables. This notebook uses execution parameters to create a XML configuration file used to run the Sounder SIPS PGEs. Papermill parameters are passed to the container through the used of the ``-p`` Papermill argument. For instance to specify the ``input_path`` parameter a call to the Docker container with ``-p input_path /pge/in`` would set the input path to ``/pge/in``. Other methods for supplying parameters to Papermill can be seen at the `Papermill execution documentation page <https://papermill.readthedocs.io/en/latest/usage-execute.html>`_. A full list of available parameters can be seen by passing the ``--help-notebook`` argument to the Docker container.

See the testing script mentioned in the next section for an example use of the container.

CWL Usage
---------

The ``spss/cwl`` directory contains an `OGC Application Package <https://docs.ogc.org/bp/20-089r1.html>`_ `CWL <https://www.commonwl.org/>`_ file for each PGE. The CWL files handle the volume mounting to the Dockage image as mentioned in the **Usage** section. The files also contain additional metadata to make the application more self descriptive.

The CWL files can be executed directly from the ``spss/cwl`` directory using `cwltool <https://github.com/common-workflow-language/cwltool>`_ using the YAML parameter files in the same directory ::

    $ cd spss/cwl
    $ cwltool --outdir /tmp/ l1a_package.cwl l1a_package.yml

Without the ``--outdir`` argument above the output would be written into the ``spss/cwl`` directory. The YAML parameter files expect there to be a symbolic link at the root level of the repository to the location of the static DEM files as mentioned in the **Testing** section below. It is recommended to use the test scripts mentioned in the next step because they handle creating a temporary directory for output files and allow more flexibility for how the static directory is located.

Testing
-------

Included in the repository are shell scripts to test execution of the L1A and L1B PGEs.  These scripts are convenient wrappers to calling the CWL files.. The only additional step needed to run the test script is to point to the location of the static files. The static files can be pointed to through either a symbolic link or through an environment variable. If using a symbolic link then create a link called ``static`` from the repository root directory to point to the static files. Alternatively declare the ``PGE_STATIC_DIR`` environment variable to point to the directory on the local system where you have stored the static files.

By default the scripts will create ``in/`` and ``out/`` subdirectories at a randomly assigned temporary directory. The directory locations will be printed to the screen. Alternatively define the ``PGE_IN_DIR`` and ``PGE_OUT_DIR`` environment variables to point to different locations. No temporary directory is created if both variables are defined.

Once you have set up the appropriate environment variables these scripts can be run without any arguments for each PGE::

    $ spss/test/run_l1a_test.sh
    $ spss/test/run_l1b_test.sh

The scripts will copy the necessary input files from the SPSS repository into into ``$PGE_IN_DIR``. Results will be placed into ``$PGE_OUT_DIR``. The L1A and L1B scripts are independent, meaning that you do not need to run the L1A script first before running the L1B script.

Development
-----------

In order to facilitate development the PGE images have a Jupyter runtime built into them. This can be accessed easily by using one of the following scripts::

    $ spss/test/launch_l1a_jupyter.sh
    $ spss/test/launch_l1b_jupyter.sh

Each will exposes port 8888 onto the local machine. Follow the directions output on screen for information on how the access the Jupyter environment. Once again both are independent of each other. The necessary input files will be staged to temporary locations should the ``PGE_IN_DIR`` and ``PGE_OUT_DIR`` environment variables not be defined prior to running the scripts.

Versioning
----------

The Docker group and Docker tag applied to the images during the docker-compose build process come from the ``.env`` file in the repository base directory. The ``DOCKER_TAG`` value should be updated for new deliveries of the algorithm.

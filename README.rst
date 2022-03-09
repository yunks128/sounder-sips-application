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

Usage
-----

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

Testing
-------

A shell script exists to test execution of the L1A PGE. This script handles the volume mounting mentioned in the **Usage** section. The only additional step needed to run the test script is to point to the location of the static files. The static files can be pointed to through either a symbolic link or through an environment variable. If using a symbolic link then create a link called ``static`` from the repository root directory to point to the static files. Alternatively declare the ``PGE_STATIC_DIR`` environment variable to point to the directory on the local system where you have stored the static files.

By default the script uses the ``in/`` and ``out/`` subdirectories under the location of test script to write files. Alternatively define the ``PGE_IN_DIR`` and ``PGE_OUT_DIR`` environment variables to point to different locations.

Once you have set up the appropriate environment variables this script can be run without any arguments::

    $ spss/test/l1a/run_l1a_test_local.sh

The script will copy L0 files from the SPSS repository into into ``$PGE_IN_DIR``. Results will be placed into ``$PGE_OUT_DIR``.

There is a second test script that will run the same test as above but will use a randomly assigned temporary directory for ``$PGE_IN_DIR`` and ``$PGE_OUT_DIR``. It uses non default paths within the container and sends their location to the Jupyter notebook as Papermill parameters. It is run without any arguments and setting ``$PGE_IN_DIR`` and ``$PGE_OUT_DIR`` will have no effect for this script::

    $ spss/test/l1a/run_l1a_test_tempdir.sh

Development
-----------

In order to facilitate development the PGE images have a Jupyter runtime built into them. This can be accessed easily by using the following script::

    $ spss/test/l1a/launch_l1a_jupyter.sh

This exposes port 8888 onto the local machine. Follow the directions output on screen for information on how the access the Jupyter environment.

Versioning
----------

The Docker group and Docker tag applied to the images during the docker-compose build process come from the ``.env`` file in the repository base directory. The ``DOCKER_TAG`` value should be updated for new deliveries of the algorithm.

TODO
----

The entry point to the PGEs has not yet been finalized. Therefore what is done by the test scripts currently is just a first step towards an actual application package.

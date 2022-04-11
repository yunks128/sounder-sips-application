cwlVersion: v1.0
class: CommandLineTool
id: l1a_pge

requirements:
  DockerRequirement:
    dockerPull: unity-sds/sounder_sips_l1a_pge:r0.1.0

arguments: [
  "$(runtime.outdir)/processed_notebook.ipynb",
  "-p", "input_path", "$(inputs.input_dir)",
  "-p", "output_path", "$(runtime.outdir)",
  "-p", "data_static_path", "$(inputs.static_dir)",
  "-p", "start_datetime", "$(inputs.start_datetime)",
  "-p", "end_datetime", "$(inputs.end_datetime)",
]

inputs:
  input_dir:
    type: Directory
  static_dir:
    type: Directory
  start_datetime:
    type: string  
  end_datetime:
    type: string  

outputs:
  output_dir:
    type: Directory
    outputBinding:
      glob: .
  stdout_file:
    type: stdout
  stderr_file:
    type: stderr

stdout: l1a_pge_stdout.txt
stderr: l1a_pge_stderr.txt

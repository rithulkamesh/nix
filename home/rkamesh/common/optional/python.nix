{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Python environment with all development packages
    (python3.withPackages (
      ps: with ps; [
        pip
        matplotlib
        pyqt5
        virtualenv
        ipython
        numpy
        scipy
        pandas
        jupyter
      ]
    ))
    tk # Tkinter for GUI support
  ];
}

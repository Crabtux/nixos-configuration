{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      ms-vscode-remote.remote-ssh

      github.copilot

      vscodevim.vim

      mhutchie.git-graph
      dracula-theme.theme-dracula
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "language-julia";
        publisher = "julialang";
        version = "1.65.2";
        sha256 = "sha256-CRAt9I4Jzg60YzyxtZZU8UF0JMnV8mGgsUmVN0adBv4=";
      }
    ];
  };
}

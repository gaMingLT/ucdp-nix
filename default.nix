let
overlay = self: super: {
   webapi = self.poetry2nix.mkPoetryApplication {
     projectDir = ./.;
     python = self.python3;
   };
  };
  hostPkgs = import <nixpkgs> { overlays = [ overlay ]; };
  linuxPkgs = import <nixpkgs> { overlays = [overlay ]; system = "x86_64-linux"; };
in
{
 inherit (hostPkgs) webapi;

 docker = hostPkgs.dockerTools.buildImage {
   name = "webapi";
   tag = "testing";
   created = "now";

   contents = linuxPkgs.webapi;
   
   config.Cmd = [ "webapi" ];
  };
}


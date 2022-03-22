{
  description = ''Nim bindings for zstd'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-zstd-master.flake = false;
  inputs.src-zstd-master.ref   = "refs/heads/master";
  inputs.src-zstd-master.owner = "wltsmrz";
  inputs.src-zstd-master.repo  = "nim_zstd";
  inputs.src-zstd-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-zstd-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-zstd-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
open Bap.Std
open Bap_primus.Std
include Self()

let init _ =
  Primus.Machine.add_component
    (module Primus_x86_loader.InitializeRegisters)
  [@warning "-D"];
  Primus.Components.register_generic
    ~package:"bap" "x86-registers-initializer"
    (module Primus_x86_loader.InitializeRegisters)
    ~desc:"Intializes all x86/x86-64 registers to zero.";

  Primus.Machine.add_component
    (module Primus_x86_loader.SetupPLT)
  [@warning "-D"];
  Primus.Components.register_generic
    ~package:"bap" "x86-setup-plt"
    (module Primus_x86_loader.SetupPLT)
    ~desc:"Sets up PLT entries."
;;

let () = Config.manpage [
  `S "DESCRIPTION";
  `P
    "Performs the x86 target specific setup. So far it just initializes
  all flag registers to zero."
];;

let () = Config.when_ready init

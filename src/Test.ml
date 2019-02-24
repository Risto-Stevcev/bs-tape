module Harness = struct
  type t
  external createStream: Stream.options -> Stream.t = "" [@@bs.send.pipe: t]
end

external test:
  ?name:string -> ?options:TestOptions.t -> (T.t -> unit) -> unit = ""
  [@@bs.module "tape"]
external skip: ?name:string -> (T.t -> unit) -> unit = "" [@@bs.module "tape"]
external only: ?name:string -> (T.t -> unit) -> unit = "" [@@bs.module "tape"]
external onFinish: (unit -> unit) -> unit = "" [@@bs.module "tape"]
external onFailure: (unit -> unit) -> unit = "" [@@bs.module "tape"]
external createHarness: unit -> Harness.t = "" [@@bs.module "tape"]
external createStream: Stream.options -> Stream.t = "" [@@bs.module "tape"]

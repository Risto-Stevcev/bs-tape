(* TODO: this represents a file stream, but there's currently no standard API for it *)
type t and options 
external options: ?objectMode:bool -> unit -> options = "" [@@bs.obj]

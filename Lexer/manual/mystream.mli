type 'a mystream =
    End
  | Cons of 'a * (unit -> 'a mystream)

val hd : 'a mystream -> 'a

val tl : 'a mystream -> unit -> 'a mystream

val string_stream : string -> char mystream

(*This is an interface fle. All those defined here are accessible in any other file*)

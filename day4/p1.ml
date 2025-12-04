open Core

type board = (bool list) list

type coord = int * int

let width (b : board) : int =
  List.length b

let height (b : board) : int =
   List.length (List.nth_exn b 0)

let in_bounds (b : board) (c : coord) : bool =
  0 <= fst c && fst c < width b && 0 <= snd c && snd c < height b

let paper_at (b : board) (c : coord) : bool =
  if in_bounds b c then List.nth_exn (List.nth_exn b (fst c)) (snd c) else false
  
let rec chars (l : string) : char list = match l with
  | "" -> []
  | x -> String.get x 0 :: chars (String.sub x ~pos:1 ~len:(String.length x - 1))

let to_board_line (inp : string) : bool list =
  List.map (chars inp) ~f:(fun m -> match m with
    | '@' -> true
    | _ -> false
  )

let count_accessible (b : board) : int = 
  let acc = ref 0 in
  let () = for x = 0 to width b - 1 do
    for y = 0 to height b - 1 do
      if paper_at b (x , y) then
        let papers = ref 0 in
        let () = for dx = -1 to 1 do
          for dy = -1 to 1 do
            if not (dx = 0 && dy = 0) && paper_at b (x + dx, y + dy) then 
              papers := !papers + 1
          done
        done in
        if !papers < 4 then
          acc := !acc + 1
    done
  done in
  !acc

let () =
  let lines = ref [] in
  let endf = ref false in
  let () = while (not !endf) do
    match In_channel.input_line In_channel.stdin with
    | Some line -> lines := to_board_line line :: !lines
    | None -> endf := true
  done in
  let acc = count_accessible !lines in
  Printf.printf "%d\n" acc 


open Core

type board = {
  width : int; 
  height : int;
  data : bool array;
}

type coord = int * int

let in_bounds (b : board) (c : coord) : bool =
  0 <= fst c && fst c < b.width && 0 <= snd c && snd c < b.height

let paper_at (b : board) (c : coord) : bool =
  if in_bounds b c then Array.get b.data (fst c + b.width * snd c) else false

let remove_paper (b : board) (c : coord) : unit =
  Array.set b.data (fst c + b.width * snd c) false
  
let rec chars (l : string) : char list = match l with
  | "" -> []
  | x -> String.get x 0 :: chars (String.sub x ~pos:1 ~len:(String.length x - 1))

let to_board_line (inp : string) : bool array =
  Array.of_list (List.map (chars inp) ~f:(fun m -> match m with
    | '@' -> true
    | _ -> false
  ))

let rec count_accessible (b : board) (prev : int) : int = 
  let removed_coords = ref [] in
  let () = for x = 0 to b.width - 1 do
    for y = 0 to b.height - 1 do
      if paper_at b (x , y) then
        let papers = ref 0 in
        let () = for dx = -1 to 1 do
          for dy = -1 to 1 do
            if not (dx = 0 && dy = 0) && paper_at b (x + dx, y + dy) then 
              papers := !papers + 1
          done
        done in
        if !papers < 4 then
          removed_coords := (x , y) :: !removed_coords
    done
  done in
  let acc = List.length !removed_coords in
  if acc = 0 then
    prev
  else
    let () = List.iter !removed_coords ~f:(fun c -> remove_paper b c) in
    count_accessible b (acc + prev)

let () =
  let lines = ref (Array.of_list []) in
  let endf = ref false in
  let width = ref 0 in
  let height = ref 0 in
  let () = while (not !endf) do
    match In_channel.input_line In_channel.stdin with
    | Some line -> 
        lines := Array.append !lines (to_board_line line);
        width := String.length line;
        height := !height + 1
    | None -> endf := true
  done in

  let board = { width = !width; height = !height; data = !lines } in
  let acc = count_accessible board 0 in

  Printf.printf "%d\n" acc 


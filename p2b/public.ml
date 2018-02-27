open OUnit2
open Data
open Funs
open Higher
open TestUtils

let test_high_order_1 ctxt =
  let x = [5.0;6.0;7.0;3.0] in
  let y = [5.0;6.0;7.0] in
  let z = [7.0;5.0] in
  let a = [3.0;5.0;8.0;10.0;9.0] in
  let b = [3.0] in

  assert_equal [true;true;true;false] @@ is_over_x 4.0 x;
  assert_equal [false;false;false] @@ is_over_x 7.0 y;
  assert_equal [true] @@ is_over_x 2.9 b;
  assert_equal [true;false] @@ is_over_x 5.1 z;
  assert_equal [true;true;true;true;true] @@ is_over_x 2.0 a;

  assert_equal 3 @@ count_over_x 4.0 x;
  assert_equal 0 @@ count_over_x 7.0 y;
  assert_equal 1 @@ count_over_x 2.9 b;
  assert_equal 1 @@ count_over_x 5.1 z;
  assert_equal 5 @@ count_over_x 2.0 a;

  assert_equal 5.25 @@ mean x;
  assert_equal 6.0 @@ mean y;
  assert_equal 6.0 @@ mean z;
  assert_equal 7.0 @@ mean a;
  assert_equal 3.0 @@ mean b

let test_high_order_2 ctxt =
  let x = [5;6;7;3] in
  let y = [5;6;7] in
  let z = [7;5] in
  let a = [3;5;8;10;9] in
  let b = [3] in
  let c = [] in

  let fs1 = [((+) 2) ; (( * ) 7)] in
  let fs2 = [pred] in
  let f1 = (fun x -> [x-1; x+1]) in
  let f2 = (fun x -> [x * 2]) in

  assert_equal [4;5;6;5;6;7;6;7;8;2;3;4] @@ pred_succ x;
  assert_equal [4;5;6;5;6;7;6;7;8] @@ pred_succ y;
  assert_equal [6;7;8;4;5;6] @@ pred_succ z;
  assert_equal [2;3;4;4;5;6;7;8;9;9;10;11;8;9;10] @@ pred_succ a;
  assert_equal [2;3;4] @@ pred_succ b;
  assert_equal [] @@ pred_succ c;

  assert_equal [7;8;9;5;35;42;49;21] @@ ap fs1 x;
  assert_equal [7;8;9;35;42;49] @@ ap fs1 y;
  assert_equal [9;7;49;35] @@ ap fs1 z;
  assert_equal [5;7;10;12;11;21;35;56;70;63] @@ ap fs1 a;
  assert_equal [5;21] @@ ap fs1 b;
  assert_equal [] @@ ap fs1 c;

  assert_equal (map pred x) @@ ap fs2 x;
  assert_equal (map pred y) @@ ap fs2 y;
  assert_equal (map pred z) @@ ap fs2 z;
  assert_equal (map pred a) @@ ap fs2 a;
  assert_equal (map pred b) @@ ap fs2 b;
  assert_equal (map pred c) @@ ap fs2 c;

  assert_equal [4;6;5;7;6;8;2;4] @@ bind f1 x;
  assert_equal [4;6;5;7;6;8] @@ bind f1 y;
  assert_equal [6;8;4;6] @@ bind f1 z;
  assert_equal [2;4;4;6;7;9;9;11;8;10] @@ bind f1 a;
  assert_equal [2;4] @@ bind f1 b;
  assert_equal [] @@ bind f1 c;

  assert_equal (map (( * ) 2) x) @@ bind f2 x;
  assert_equal (map (( * ) 2) y) @@ bind f2 y;
  assert_equal (map (( * ) 2) z) @@ bind f2 z;
  assert_equal (map (( * ) 2) a) @@ bind f2 a;
  assert_equal (map (( * ) 2) b) @@ bind f2 b;
  assert_equal (map (( * ) 2) c) @@ bind f2 c

let test_int_tree ctxt =
  let t0 = empty_int_tree in
  let t1 = (int_insert 3 (int_insert 11 t0)) in
  let t2 = (int_insert 2 t1) in
  let t3 = (int_insert 5 (int_insert 3 (int_insert 1 t2))) in
  let x = [5;6;8;3;0] in
  let z = [7;5;6;5;1] in
  let t4a = int_insert_all x t1 in
  let t4b = int_insert_all z t1 in

  assert_equal 0 @@ (int_size t0);
  assert_equal 2 @@ (int_size t1);
  assert_equal 3 @@ (int_size t2);
  assert_equal 5 @@ (int_size t3);

  assert_raises (Invalid_argument("int_min")) (fun () -> int_min t0);
  assert_equal 3 @@ int_min t1;
  assert_equal 2 @@ int_min t2;
  assert_equal 1 @@ int_min t3;

  assert_equal [true;true;true;true;true] @@ map (fun y -> int_mem y t4a) x;
  assert_equal [true;true;false;true;false] @@ map (fun y -> int_mem y t4b) x;
  assert_equal [false;true;true;true;false] @@ map (fun y -> int_mem y t4a) z;
  assert_equal [true;true;true;true;true] @@ map (fun y -> int_mem y t4b) z

let test_int_common_1 ctxt =
  let p0 = empty_int_tree in
  let p1 = (int_insert 2 (int_insert 5 p0)) in
  let p3 = (int_insert 10 (int_insert 3 (int_insert 11 p1))) in
  let p4 = (int_insert 15 p3) in
  let p5 = (int_insert 1 p4) in

  assert_equal 5 @@ int_common p5 1 11;
  assert_equal 5 @@ int_common p5 1 10;
  assert_equal 5 @@ int_common p5 2 10;
  assert_equal 2 @@ int_common p5 2 3;
  assert_equal 11 @@ int_common p5 10 11;
  assert_equal 11 @@ int_common p5 11 11

let test_int_common_2 ctxt =
  let q0 = empty_int_tree in
  let q1 = (int_insert 3 (int_insert 8 q0)) in
  let q2 = (int_insert 2 (int_insert 6 q1)) in
  let q3 = (int_insert 12 q2) in
  let q4 = (int_insert 16 (int_insert 9 q3)) in

  assert_equal 3 @@ int_common q4 2 6;
  assert_equal 12 @@ int_common q4 9 16;
  assert_equal 8 @@ int_common q4 2 9;
  assert_equal 8 @@ int_common q4 3 8;
  assert_equal 8 @@ int_common q4 6 8;
  assert_equal 8 @@ int_common q4 12 8;
  assert_equal 8 @@ int_common q4 8 16

let test_ptree ctxt =
  let r0 = empty_ptree Pervasives.compare in
  let r1 = (pinsert 2 (pinsert 1 r0)) in
  let r2 = (pinsert 3 r1) in
  let r3 = (pinsert 5 (pinsert 3 (pinsert 11 r2))) in
  let a = [5;6;8;3;11;7;2;6;5;1]  in

  let strlen_comp x y = Pervasives.compare (String.length x) (String.length y) in
  let k0 = empty_ptree strlen_comp in
  let k1 = (pinsert "hello" (pinsert "bob" k0)) in
  let k2 = (pinsert "sidney" k1) in
  let k3 = (pinsert "yosemite" (pinsert "ali" (pinsert "alice" k2))) in
  let b = ["hello"; "bob"; "sidney"; "kevin"; "james"; "ali"; "alice"; "xxxxxxxx"] in

  assert_equal [false;false;false;false;false;false;false;false;false;false] @@ map (fun y -> pmem y r0) a;
  assert_equal [false;false;false;false;false;false;true;false;false;true] @@ map (fun y -> pmem y r1) a;
  assert_equal [false;false;false;true;false;false;true;false;false;true] @@ map (fun y -> pmem y r2) a;
  assert_equal [true;false;false;true;true;false;true;false;true;true] @@ map (fun y -> pmem y r3) a;

  assert_equal [false;false;false;false;false;false;false;false] @@ map (fun y -> pmem y k0) b;
  assert_equal [true;true;false;true;true;true;true;false] @@ map (fun y -> pmem y k1) b;
  assert_equal [true;true;true;true;true;true;true;false] @@ map (fun y -> pmem y k2) b;
  assert_equal [true;true;true;true;true;true;true;true] @@ map (fun y -> pmem y k3) b

let test_graph_1 ctxt =
  let g = add_edges
      [ { src = 1; dst = 2; };
        { src = 2; dst = 3; };
        { src = 3; dst = 4; };
        { src = 4; dst = 5; } ] empty_graph in
  let g2 = add_edges
      [ { src = 1; dst = 2; };
        { src = 3; dst = 4; };
        { src = 4; dst = 3; } ] empty_graph in
  let g3 = add_edges
      [ { src = 1; dst = 2; };
        { src = 1; dst = 3; };
        { src = 3; dst = 2; };
        { src = 2; dst = 1; } ] empty_graph in

  assert_equal true @@ graph_empty empty_graph;
  assert_equal false @@ graph_empty g;
  assert_equal false @@ graph_empty g2;

  assert_equal 0 @@ graph_size empty_graph;
  assert_equal 5 @@ graph_size g;
  assert_equal 4 @@ graph_size g2;
  assert_equal 3 @@ graph_size g3

let test_graph_2 ctxt =
  let p = add_edges
      [ { src = 1; dst = 2; };
        { src = 2; dst = 3; };
        { src = 3; dst = 4; };
        { src = 4; dst = 5; } ] empty_graph in
  let p2 = add_edges
      [ { src = 1; dst = 2; };
        { src = 3; dst = 4; };
        { src = 4; dst = 3; } ] empty_graph in
  let p3 = add_edges
      [ { src = 1; dst = 2; };
        { src = 1; dst = 3; };
        { src = 3; dst = 2; };
        { src = 2; dst = 1; } ] empty_graph in

  assert_equal [2] @@ (map (fun { dst = d } -> d) (src_edges 1 p));
  assert_equal [3] @@ (map (fun { dst = d } -> d) (src_edges 2 p));
  assert_equal [] @@ (map (fun { dst = d } -> d) (src_edges 5 p));
  assert_equal [2] @@ (map (fun { dst = d } -> d) (src_edges 1 p2));
  assert_equal [] @@ (map (fun { dst = d } -> d) (src_edges 2 p2));
  assert_equal [4] @@ (map (fun { dst = d } -> d) (src_edges 3 p2));
  assert_equal [1] @@ (map (fun { dst = d } -> d) (src_edges 2 p3));
  assert_equal [] @@ (map (fun { dst = d } -> d) (src_edges 4 p3));
  assert_equal [2;3] @@ (map (fun { dst = d } -> d) (src_edges 1 p3));

  assert_equal [true] @@ (map (fun e -> is_dst 2 e) (src_edges 1 p));
  assert_equal [true] @@ (map (fun e -> is_dst 2 e) (src_edges 1 p2));
  assert_equal [true;false] @@ (map (fun e -> is_dst 2 e) (src_edges 1 p3))

let suite =
  "public" >::: [
    "high_order_1" >:: test_high_order_1;
    "high_order_2" >:: test_high_order_2;
    "int_tree" >:: test_int_tree;
    "common_1" >:: test_int_common_1;
    "common_2" >:: test_int_common_2;
    "ptree" >:: test_ptree;
    "graph_1" >:: test_graph_1;
    "graph_2" >:: test_graph_2
  ]

let _ = run_test_tt_main suite

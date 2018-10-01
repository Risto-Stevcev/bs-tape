open Test

module Plan = struct
  test @@ fun t -> begin
    t |> T.plan 2;
    t |> T.ok true;
    t |> T.equal 123 123;
  end;;

  skip @@ fun t -> begin
    t |> T.plan 2;
    t |> T.ok true;
  end
end

module Fail = struct
  skip @@ fun t -> begin
    t |> T.fail "this failed"
  end
end

module Pass = struct
  test @@ fun t -> begin
    t |> T.pass "this passed";
    t |> T.end_
  end
end

module TimeoutAfter = struct
  test @@ fun t -> begin
    let ms = 200 in
    t |> T.timeoutAfter ms;
    (ms - 10) |> Js.Global.setTimeout (fun _ -> t |> T.end_) |> ignore
  end;;

  skip @@ fun t -> begin
    let ms = 200 in
    t |> T.timeoutAfter ms;
    (ms + 10) |> Js.Global.setTimeout (fun _ -> t |> T.end_) |> ignore
  end
end

module Ok = struct
  test @@ fun t -> begin
    t |> T.ok "foo";
    t |> T.notOk "";
    t |> T.end_
  end;;

  skip @@ fun t -> begin
    t |> T.ok "";
    t |> T.notOk "foo";
    t |> T.end_
  end
end

module Equal = struct
  test @@ fun t -> begin
    t |> T.equal "foo" "foo";
    t |> T.notEqual "foo" "bar";
    t |> T.end_
  end;;

  skip @@ fun t -> begin
    t |> T.equal "foo" "bar";
    t |> T.notEqual "foo" "foo";
    t |> T.end_
  end
end

module DeepEqual = struct
  test @@ fun t -> begin
    t |> T.deepEqual [%obj {foo=123}] [%obj {foo=123}];
    t |> T.notDeepEqual [%obj {foo=123}] [%obj {foo=456}];
    t |> T.end_
  end;;

  skip @@ fun t -> begin
    t |> T.equal [%obj {foo=123}] [%obj {foo=123}];
    t |> T.deepEqual [%obj {foo=123}] [%obj {foo=456}];
    t |> T.notDeepEqual [%obj {foo=123}] [%obj {foo=123}];
    t |> T.end_
  end
end

module Throws = struct
  test @@ fun t -> begin
    t |> T.throws (fun _ -> Js.Exn.raiseError "throws");
    t |> T.end_
  end;;

  skip @@ fun t -> begin
    t |> T.doesNotThrow (fun _ -> Js.Exn.raiseError "throws");
    t |> T.end_
  end
end

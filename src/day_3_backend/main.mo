import Text "mo:base/Text";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Trie "mo:base/Trie";
import List "mo:base/List";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
// import HTTP "http";

// import Time "mo:base/Time";
import MyCustom "my_custom";
import Animal "animal";
import CustomList "list";
import Cycles "mo:base/ExperimentalCycles";



actor {
  // challenge 1 to 6
  type Pietree = MyCustom.Pietree;
  public func fun () : async Pietree {
    {
      age = 3;
      height = 5.4;
      watered = false;
    }
  };

  var dog : Animal.Animal = {
    specie = "Dog";
    energy = 90;
  };

  public func create_animal_then_takes_a_break ( specie : Text, energy : Nat) : async Animal.Animal {
    Animal.animal_sleep({
      specie;
      energy;
    })
  };

  var l = List.nil<Animal.Animal>();
  
  
  // l := List.push<Animal.Animal>({
  //   specie = "meo";
  //   energy = 23;
  // }, l);
  

  public func push_animals (a : Animal.Animal) : async () {
    l := List.push<Animal.Animal>(a, l);
  };
  public func get_animals () : async List.List<Animal.Animal> {l};
  
  // challenge 7 to 10

  type CustomList<T> = CustomList.CustomList<T>;
  public func test_custom_list() : async CustomList<Nat>{
    var l : CustomList<Nat> = CustomList.nil<Nat>();

    Debug.print("1. check list is null: "#debug_show(CustomList.is_null(l)));

    l := CustomList.push<Nat>(l, 5);
    l := CustomList.push<Nat>(l, 8);
    l := CustomList.push<Nat>(l, 12);

    Debug.print("2. init list with some value: "#debug_show(l));
    Debug.print("3. get last value (most-right): "#debug_show(CustomList.last(l)));

    l := CustomList.push<Nat>(l, 16);
    Debug.print(debug_show(CustomList.last(l)));
    Debug.print("4. add more value: "#debug_show(l));
    Debug.print("5. get size of list: "#debug_show(CustomList.size(l)));
    return l;
  };

  let anonymous_principal : Principal = Principal.fromText("2vxsx-fae");
  // let users = HashMap.HashMap<Principal, Text>(0, Principal.equal, Principal.hash);
  // users.put(anonymous_principal, "This is the anonymous principal");

  public shared({caller}) func is_anonymous () : async Bool {
    Principal.isAnonymous(caller)
  };

  
  // private func gt (n : Nat) : Nat {
  //   switch (n) {
  //     case (0) { return 1; };
  //     case (_) { return n*gt(n-1); };
  //   }
  // };

  // public func get_gt (n : Nat) : async Nat {
  //   return gt(n);
  // };


  var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
  type FavorResult = {#ok : Text; #dup : Text};
  // type FavorResult<T,E> = Result.Result<T, E>;

  // dfx canister call day_3_backend add_favorite_number '(5)'
  public shared(caller) func add_favorite_number ( n : Nat ) : async FavorResult {
    switch (favoriteNumber.get(caller.caller)) {
      case null {
        favoriteNumber.put(caller.caller, n);
        return #ok ("You've successfully registered your number");
      };
      case (_) {#dup ("You've already registered your number")}
    }
  };
  // dfx canister call day_3_backend show_favorite_number '()'
  public shared(caller) func show_favorite_number () : async ?Nat {
    favoriteNumber.get(caller.caller)
  };
  // dfx canister call day_3_backend update_favorite_number '(8)'
  public shared(caller) func update_favorite_number ( n : Nat ) : async () {
    favoriteNumber.put(caller.caller, n);
  };

  // dfx canister call day_3_backend delete_favorite_number '()'
  public shared(caller) func delete_favorite_number () : async ?Nat {
    favoriteNumber.remove(caller.caller);
  };

  public shared(caller) func deposit_cycles () : async Nat {
    Cycles.available()
  };

  public func balance() : async Nat {
    return(Cycles.balance())
  };

};

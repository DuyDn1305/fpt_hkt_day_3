import Text "mo:base/Text";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Trie "mo:base/Trie";
import List "mo:base/List";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";

// import Debug "mo:base/Debug";
// import HTTP "http";

// import Time "mo:base/Time";

actor {
    
  stable var entries : [( Principal, Nat)] = [];

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

  system func preupgrade() {
    entries := Iter.toArray(favoriteNumber.entries());
  }; 

}
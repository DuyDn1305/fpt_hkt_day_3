module {
    // type Item<T> = {
    //     data : T;
    //     next : ?Item;
    // };

    public type CustomList<T> = ?(T, CustomList<T>);

    public func is_null<T>(l : CustomList<T>) : Bool {
        switch (l) {
            case null {return true;};
            case (_) {return false;};
        }
    };
    public func last<T>(l : CustomList<T>) : ?T {
        switch (l) {
            case (null) {return null;};
            case (?(val, null)) { ?val };
            case (?(_, next)) { last<T>(next) };
        }
    };
    public func size<T>(l : CustomList<T>) : Nat {
        switch (l) {
            case null {return 0};
            case (?(_, node)) {
                return 1+size<T>(node);
            };
        }
    };
    public func get<T>(l : CustomList<T>, index : Nat) : ?T {
        switch (l) {
            case (null) { return null; };
            case (?(val, node)) {
                switch (index) {
                    case (0) { ?val };
                    case (_) {
                        return get<T>(node, index-1);
                    };
                };
            };
        }
    };

    public func push<T> (l : CustomList<T>, t : T) : CustomList<T> {
        ?(t, l)
    };

    public func nil<T>() : CustomList<T> {null};
}
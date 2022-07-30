module {
    // (specie of type Text, energy of type Nat)
    public type Animal = {
        specie : Text;
        energy : Nat;
    };

    public func animal_sleep (a : Animal) : Animal {
        {
            specie = a.specie;
            energy = a.energy + 10;
        }
    };

}
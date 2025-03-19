module CharityDAO::Charity {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    struct CharityFund has store, key {
        total_donations: u64,
    }

    /// Function to initialize a charity fund.
    public fun create_charity(owner: &signer) {
        let fund = CharityFund {
            total_donations: 0,
        };
        move_to(owner, fund);
    }

    /// Function to donate funds to the charity.
    public fun donate(donor: &signer, charity_address: address, amount: u64) acquires CharityFund {
        let fund = borrow_global_mut<CharityFund>(charity_address);
        let donation = coin::withdraw<AptosCoin>(donor, amount);
        coin::deposit<AptosCoin>(charity_address, donation);
        fund.total_donations = fund.total_donations + amount;
    }
}

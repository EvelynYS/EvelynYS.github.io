const Search = () => {
    return (
        <header>
            <h1 className="header__title">Let's find our home.</h1>
            <input
                type="text"
                className="header__search"
                placeholder="Enter an address, neighborhood, city, or ZIP code"
            />
        </header>
    );
}

export default Search;
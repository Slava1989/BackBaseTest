# BackBaseTest

In CityScreenPresenter I have saved sorted data in variable sortedCities, then have split all cities into a dictionary, where key is first lettter of city's name (lowercased) and values - array of cities.
This will help in filtering data, when user enters smth in TextField, first of all, the algorithm finds the needed array in the dictionary, then, using the 2 pointers algorithm, I'm searching the names of cities with needed prefix.

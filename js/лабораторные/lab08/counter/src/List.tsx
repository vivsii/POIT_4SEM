import React, { useState } from 'react';

function List() {
    const [cities, setCities] = useState(['Ивацевичи', 'Минск', 'Париж', 'Витебск', 'Брест']);
    const [isAscending, setIsAscending] = useState(true);

    const handleSortCities = () => {
        const sortedCities = [...cities].sort((a, b) => {
            if (isAscending) {
                return a.localeCompare(b);
            } else {
                return b.localeCompare(a);
            }
        });
        setCities(sortedCities);
        setIsAscending(!isAscending);
    };

    return (
        <div>
            <h3>Города</h3>
            <ul>
                {cities.map((city, index) => (
                    <li key={index} onClick={index === 0 ? handleSortCities : undefined}>{city}</li>
                ))}
            </ul>
        </div>
    );
}

export default List;

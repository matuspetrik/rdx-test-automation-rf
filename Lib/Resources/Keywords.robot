*** Keywords ***

Get rid of GDPR disclaimer
    Click element               ${disclaimer}       # click to get rid of cookies disclaimer

Navigate to category "${category}" "${subcategory}"
    [Documentation]             Navigate to the desired category.
    ...                         In this case: notebooks/notebooks-14-lcd

    ${elm_l0_xpath}             Set variable    //a[@href="/${category}"]
    ${elm_l1_xpath}             Set variable    //a[@href="/${subcategory}"]
    Click element               ${elm_l0_xpath}     # open menu level 0 item
    Click element               ${elm_l1_xpath}     # open menu level 1 item

Sort by "${val:(most|least)}" expensive
    [Documentation]             Sort by either most or least expensive item.

    Wait until element is visible
    ...                         ${sort_xpath}
    Click element               ${sort_xpath}

    ${element}                  Set variable if     "${val}" == "most"
    ...                             ${most_expensive}
    ...                             ${least_expensive}
    Wait until element is visible
    ...                         ${element}      timeout=10
    Click element               ${element}
    Wait until element is visible
    ...                         ${buy_button}   timeout=10

    Sleep                       ${TIMEOUT}

Add first "${number_of}" items to cart
    [Documentation]             Add number of first listed items to cart

    @{elmts}                    Get webelements
    ...                             ${buy_items}

    FOR     ${row}  ${elm}      IN ENUMERATE    @{elmts}
        ${row_h}                Set variable    ${${row} + 1}
        Wait until keyword succeeds     10x     1s
        ...                     Click button           ${elm}
        Wait until keyword succeeds     10x     1s
        ...                     Click element           ${elm_contshop}
        Exit for loop if        ${row_h} == ${number_of}
    END

Visually validate shopping cart for "${number_of}" "${time_unit}"
    [Documentation]             Display content of shopping cart for
    ...                         number of seconds before the test quits.

    Click element               ${shopping_cart}
    Sleep                       ${number_of} ${time_unit}

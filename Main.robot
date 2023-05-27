*** Settings ***
Documentation
...                             Go to your favorite e-shop,
...                             navigate to some category and
...                             add two most expensive items to the shopping
...                             cart from this category.

Library                         SeleniumLibrary

Suite Setup                     Run keywords
...                                 Open Browser
...                                     url=${ESHOP_URL}
...                                     browser=${BROWSER}
...                                 AND     No operation
...                                 AND     Maximize Browser Window

Suite Teardown                  Close Browser

Test teardown                   Sleep   ${SLEEP}

*** Variables ***
${BROWSER}                      chrome
${ESHOP_URL}                    http://focus.sk
${SLEEP}                        2

*** Keywords ***
Get rid of GDPR disclaimer
    ${disclaimer}               Set variable
    ...                             //button[@class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"]
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

    ${sort_xpath}               Set variable
    ...                             //div[@id="sortOptionsDropDown"]/div[@class="toplevel"]
    Click element               ${sort_xpath}

    ${element}                  Set variable if     "${val}" == "most"
    ...                             xpath://ul[@class="sublevel"]/li/span[@data-dropdownoptionvalue="11"]
    ...                             xpath://ul[@class="sublevel"]/li/span[@data-dropdownoptionvalue="10"]
    Click element               ${element}

    Sleep                       ${SLEEP}

Add first "${number_of}" items to cart
    [Documentation]             Add number of first listed items to cart

    @{elmts}                    Get webelements
    ...                             xpath://div[@class="item-grid"]/div/div/div/div/div/div[@class="buttons"]

    FOR     ${row}  ${elm}      IN ENUMERATE    @{elmts}
        ${row_h}                Set variable    ${${row} + 1}
        Click element           ${elm}
        Sleep                   ${SLEEP}
        Click element           xpath://a[@class="continueShoppingLink"]
        ${elm_item}             Get webelements     ${elm}
        Exit for loop if        ${row_h} == ${number_of}
    END

Display shopping cart for "${number_of}" "${time_unit}"
    [Documentation]             Display content of shopping cart for
    ...                         number of seconds before the test quits.

    ${shopping_cart}            Set variable
    ...                             //div[@class="block-mini-cart"]/strong//a[@href="/cart"]
    Click element               ${shopping_cart}
    Sleep                       ${number_of} ${time_unit}

*** Test cases ***
Fill the shopping cart
    [Documentation]             Fill the shopping cart with first 2
    ...                         most expensive items.
    [Tags]                      SHOPPING

    Get rid of GDPR disclaimer
    Navigate to category "notebooky" "notebooky-14-lcd"
    Sort by "most" expensive
    Add first "2" items to cart
    Display shopping cart for "10" "seconds"
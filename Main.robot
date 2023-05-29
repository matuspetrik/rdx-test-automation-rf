*** Settings ***
Documentation
...                             Go to your favorite e-shop,
...                             navigate to some category and
...                             add two most expensive items to the shopping
...                             cart from this category.

Resource                        %{WORKSPACE}/Lib/Resources/Includes.resource

Suite Setup                     Run keywords
...                                 Open Browser
...                                     url=${ESHOP_URL}
...                                     browser=${BROWSER}
...                                 AND     No operation
...                                 AND     Maximize Browser Window

Suite Teardown                  Close Browser

*** Variables ***
# Stored in separate file: %{WORKSPACE}/Lib/Resources/Variables.yaml

*** Keywords ***
# Stored in separate file: %{WORKSPACE}/Lib/Resources/Keywords.robot

*** Test cases ***
Fill the shopping cart
    [Documentation]             Fill the shopping cart with first 2
    ...                         most expensive items.
    [Tags]                      SHOPPING

    Get rid of GDPR disclaimer
    Navigate to category "notebooky" "notebooky-14-lcd"
    Sort by "most" expensive
    Add first "2" items to cart
    Visually validate shopping cart for "10" "seconds"
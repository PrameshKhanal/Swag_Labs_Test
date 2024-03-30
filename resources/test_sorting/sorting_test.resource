*** Settings ***
Library        Browser
Library        String
Library        Collections

Resource       suite_management${/}manage_screenshots.resource     

*** Keywords ***
Get Price List
    [Documentation]        This keyword will create the price list without the $ symbol.
    ...                    The web element targetting all the prices is provided as argument.
    [Arguments]    ${priceslements}
    ${pricelements}                                         Browser.Get Elements    ${priceslements}
    ${pricelist}                                            Create List
    FOR  ${pricelement}  IN  @{pricelements}
        Log   ${pricelement}
        ${price}    Browser.Get Text    ${pricelement}
        ${symbolstrip}    String.Strip String    string=${price}    characters=$
        ${convert}    Convert To Number    item=${symbolstrip}
        Collections.Append To List    ${pricelist}    ${convert}
        Log    ${symbolstrip}
    END
    RETURN    ${pricelist}

Verify Low to high price sorting
    [Documentation]                                         This test will login using the exisiting username and password. From the main product page, 
    ...                                                     this test will verify that the low to high sorting option will sort the items correctly.
    ...                                                     After the sorting is performed, this test will take the screenshot as evidence.
    [Tags]                                                  low2high
    Browser.Type Text                                       id=user-name    standard_user
    Browser.Type Text                                       id=password     secret_sauce
    Browser.Click                                           id=login-button
    Browser.Wait For Elements State                         css=select.product_sort_container    visible    timeout=5s
    ${mylist}    Get Price List                css=div.inventory_item_price
    Collections.Sort List    ${mylist}
    Log    ${mylist}
    Browser.Select Options By                               css=select.product_sort_container    text       Price (low to high)
    ${sortedlist}    Get Price List            css=div.inventory_item_price
    Collections.Lists Should Be Equal    list1=${mylist}    list2=${sortedlist}    values=True    ignore_order=False
    manage_screenshots.Take full page screenshot            filename=page_sorted
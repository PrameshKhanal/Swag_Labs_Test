*** Settings ***
Library        Browser
Library        String
Library        Collections

Resource       test_login${/}login_test.resource

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

Verify Low To High Sorting
    [Documentation]                                         This test will login using the exisiting username and password. From the main product page, 
    ...                                                     this test will verify that the low to high sorting option will sort the items correctly.
    ...                                                     After the sorting is performed, this test will take the screenshot as evidence.
    [Tags]                                                  low2high
    Browser.Type Text                                       id=user-name    standard_user
    Browser.Type Text                                       id=password     secret_sauce
    Browser.Click                                           id=login-button
    Browser.Wait For Elements State                         css=select.product_sort_container    visible    timeout=5s
    ${mylist}    Get Price List                             css=div.inventory_item_price
    Collections.Sort List    ${mylist}
    Log    ${mylist}
    Browser.Select Options By                               css=select.product_sort_container    text       Price (low to high)
    ${sortedlist}    Get Price List                         css=div.inventory_item_price
    Collections.Lists Should Be Equal                       list1=${mylist}    
    ...                                                     list2=${sortedlist}    
    ...                                                     values=True    
    ...                                                     ignore_order=False
    manage_screenshots.Take full page screenshot            filename=price_low_to_high
    Browser.Click                                           id=react-burger-menu-btn
    Browser.Wait For Elements State                         id=logout_sidebar_link    visible    timeout=5s
    Browser.Click                                           id=logout_sidebar_link
    Browser.Wait For Elements State                         id=login-button    visible    timeout=10s

Verify High To Low Sorting
    [Documentation]                                         This test will login using the exisiting username and password. From the main product page, 
    ...                                                     this test will verify that the high to low sorting option will sort the items correctly.
    ...                                                     After the sorting is performed, this test will take the screenshot as evidence.
    [Tags]                                                  high2low
    login_test.Login With Standard User
    ${mylist}    Get Price List                             css=div.inventory_item_price
    Collections.Sort List                                   ${mylist}
    Collections.Reverse List                                ${mylist}
    Log                                                     ${mylist}
    Browser.Select Options By                               css=select.product_sort_container    text       Price (high to low)
    ${sortedlist}    Get Price List                         css=div.inventory_item_price
    Collections.Lists Should Be Equal                       list1=${mylist}    
    ...                                                     list2=${sortedlist}    
    ...                                                     values=True    
    ...                                                     ignore_order=False
    manage_screenshots.Take full page screenshot            filename=price_high_to_low
    Browser.Click                                           id=react-burger-menu-btn
    Browser.Wait For Elements State                         id=logout_sidebar_link    visible    timeout=5s
    Browser.Click                                           id=logout_sidebar_link
    Browser.Wait For Elements State                         id=login-button    visible    timeout=10s
*** Settings ***
Library        Browser
Library        String
Library        Collections

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
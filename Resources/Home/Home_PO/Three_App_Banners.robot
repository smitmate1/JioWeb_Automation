*** Settings ***
Library                                              SeleniumLibrary
Resource                                             ../../Local_Keywords.robot

*** Keywords ***
Three promotional cards validation

    #Three banners section
    Scroll To                                         xpath=//div[contains(@class,'j-promo-card bg--primary size--xs')]

    # Returns a list of cards present with the same locator
    ${promo_cards}=    Get WebElements                   xpath=//div[contains(@class,'j-promo-card bg--primary size--xs')]
    
    # Gets the count of the card present
    ${promo_cards_length}=     Get Length     ${promo_cards}

    Log To Console    ${promo_cards_length} Promo cards found
    
    FOR  ${promo_card}  IN  @{promo_cards}
        # Verifies the card present 
        Wait For And Verify Element                   ${promo_card}
    END
    
    #Three Banner Buttons Redirection
    ${VB}  Set Variable   0
    WHILE  ${VB} != ${promo_cards_length}

        #Redirection of all 3 cards present 

        Wait For And Click Element                    xpath=//button//div[contains(text(),'${ThreeAppsBanner_button}[${VB}]')]   
        Sleep        1s
        Check Window count and Validation             ${ThreeAppsBanner_URL}[${VB}]                ${ThreeAppsBanner_button}[${VB}]
        ${VB}=   Evaluate    ${VB} + 1
    END

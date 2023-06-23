*** Settings ***
Library                                 SeleniumLibrary
Resource                                ../../Resources/Shop/ShopAddtoCart_Page.robot
Resource                                ../../Resources/Common.robot
Variables                               AddtoCart_Variables.yaml 
Resource                                ../../Resources/Tags.robot
Variables                               ../../Resources/Tester_Input.yaml 
# Suite Setup                             Shop Add To Cart Tag Activity
Test Setup                              Begin Web Test
Test Teardown                           End Web Test

*** Test Cases ***
Confirm Add to Cart Button Functionality 
    [Tags]    ${TC01-SAdd to Cart}    TC01-SAdd_to_Cart    Sanity    test
    [Documentation]    This is 1st to 16th Test case (TC14 Out of Scope)
    Verifying Add to Cart Button Functionality 

Confirm the functionality of form elements of Shopping Cart
    [Tags]    ${TC17-SAdd to Cart}    TC17-SAdd_to_Cart    Sanity
    [Documentation]   This is 17th to 26th Test case
    Checking the functionality of form elements on Shopping Cart
    







*** Settings ***
Resource                            ../../../Local_Keywords.robot

*** Keywords ***
Checking PriceRange Filter UI               #Testcase:92710
    Click Show Filter Option
    #Site issue
    # Appling slider filter price
    Applying Slider Filter          xpath=(//div[@class="filters-container"])[1]    Price range
    Confirm product list is modified as per "Price filter"
    Remove Filter

Checking Battery capacity Filter UI        #Testcase:92711
    Click Show Filter Option
    Applying Slider Filter          xpath=(//div[@class="filters-container"])[4]    Battery capacity
    Remove Filter

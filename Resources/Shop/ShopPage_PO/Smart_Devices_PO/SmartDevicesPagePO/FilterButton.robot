*** Settings ***
Resource                          ../../../../Local_Keywords.robot

*** Keywords ***
Checking PriceRange Filter UI
    # Clicking Show Filter Option In Right Hand Side
    Click Show Filter Option
    # Applying Price Filter Slider
    Applying Slider Filter        xpath=(//div[@class="filters-container"])[2]    Price range
    # Checking product list modified as per "Price filter"                    Testcase: 92700
    Confirm product list is modified as per "Price filter"
    # Removing Filter by clicking cross icon                                  Testcase: 92701
    Remove Filter

Checking Filter Brand UI
    # Clicking Show Filter Option In Right Hand Side
    Click Show Filter Option
    ${brand}    Set Variable      Apple
    # Applying Checkbox  Filter 
    Applying CheckBox Filter      xpath=(//div[@class="filter-section"])[3]    Brand    ${brand}
    Verify Checkbox Filter        ${brand}
    # Checking product list modified as per "Brand filter"                    Testcase: 92702
    Confirm product list is modified as per "Brand filter"                 ${brand}
    # Removing Filter by clicking cross icon
    Remove Filter

Checking Multiple Filter
    Click Show Filter Option
    ${brand}    Set Variable    Apple
    Wait For And Verify Element    //div[@class="slider-container"]/input
    Wait For And Click Element     (//div[@class="slider-container"]/input)[1]
    Drag And Drop By Offset        (//div[@class="slider-container"]/input)[1]     0    0
    ${max_val}=    Get Text    //span[@id='priceSliderDisplayValue']
    #Getting Min Value
    ${min_val}=    Get Element Attribute        //div[@class="slider-container"]/input    min

    # Removing "," From Max & Min Values And Converting Price Text To Integer
    ${max_val}=    Remove String             ${max_val}    ,
    ${min_val}=    Remove String             ${min_val}    ,
    Set Global Variable    ${max_val}        ${max_val}
    Set Global Variable    ${min_val}        ${min_val}
 
    Applying CheckBox Filter       xpath=(//div[@class="filters-container"])[4]    Brand    ${brand}
    Wait For And Verify Content    (//li[@class='applied-filtervalue']//a//span)[1]    ${brand}
    ${Filter_Price}=    Get Text   (//li[@class='applied-filtervalue']//a//span)[2]
    Should Contain     ${Filter_Price}    ${max_val}
    Should Contain     ${Filter_Price}    ${min_val}
    Remove Filter

Checking Various Filter options
    Checking Filter UI & Functionality
    Checking PriceRange Filter UI
    Checking Filter Brand UI
    Checking Multiple Filter

#########################NOTAS############################
robot  -d ./ReportsEx1 ex1_AutoTestes.robot
#########################################################


*** Settings ***
Library  SeleniumLibrary
Library    DateTime
Documentation  Pontos a considerar na resolução do desafio
...    Apagar as linhas nos testes que tem escrito "No operation"
...    Documentação da biblioteca do Selenium: https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Input%20Text"
...    Keywords que podems ser usadas: Input Text / Select Checkbox / Select From List By Index / Select From List By Label
...                                    Select From List By Value / Click Button / Click Element / Click Link / Choose File
...                                    Element Should Be Visible / Element Should Contain / Element Text Should Be
 

*** Keywords ***
Validar Diferenca Entre Datas
   [Tags]    testautomationpractice
   
   [Arguments]         ${start_date}    ${end_date}

    ${start}   Convert Date    ${start_date}    result_format=%Y-%m-%d
    ${end}     Convert Date    ${end_date}      result_format=%Y-%m-%d
    ${diff}    Subtract Date From Date    ${end}    ${start}

    ${num}   Evaluate    ${diff}/ 86400
    ${num}   Convert To Integer   ${num}
    ${num}   Convert To String    ${num}
    RETURN   ${num}

Acessar Aplicacao testautomationpractice (nao necessita login)           # robot -i testautomationpractice -d ./ReportsEx1testautomationpractice ex1_AutoTestes.robot 
     [Tags]    testautomationpractice
     # Acessar a URL: https://testautomationpractice.blogspot.com/ 
     Open Browser  https://testautomationpractice.blogspot.com/  chrome
     sleep  3

Acessar Aplicacao Saucedemo (com login e pass)                           # robot -i Saucedemo -d ./ReportsEx1Saucedemo ex1_AutoTestes.robot  
     [Tags]    Saucedemo
     # Acessar a URL: https://www.saucedemo.com/
     Open Browser  https://www.saucedemo.com/  chrome
     sleep  3
     # Preencha o campo "usernames"
     Wait Until Element Is Enabled  xpath://input[@placeholder="Username"]
     Input Text  xpath://input[@placeholder="Username"]  ${UsernameSaucedemo}
     # Preencha o campo "Password"
     Input Text  xpath://input[@placeholder="Password"]  ${PasswordSaucedemo}
     # Clicar no botão "Login"
    Click Element  xpath://input[@id="login-button"]
    sleep  3
     # Validar se esta na pagina correta ao ligar
     Element Should Be Visible  //div[@class='app_logo' and text()='Swag Labs']

*** Variables ***
${UsernameSaucedemo}  standard_user                                           # Aqui é a zona de variaveis (esta é uma variavel simples)
${PasswordSaucedemo}  secret_sauce  
@{gender}  male  female                                                                     #Esta é uma variavel tipo array/Lista, para aceder à 1a posição (male) é: ${gender}[0]
@{dias_da_semana}  saturday  sunday  monday  tuesday  wednsday  thursday  friday  saturday  #Esta é uma variavel tipo array/Lista, para aceder à 2a posição (sunday) é: ${dias_da_semana}[1]
&{Cadastro}  nome=Samuel  email=sam@gmail.com  telefone=931222333  address=Rua da paz          #Dicionário: Esta é uma variavel par - valor. Para aceder, utilizar: ${Cadastro.nome} ou ${Cadastro.email} 

${TODAY}

*** Test Cases ***

Preencher o formulario testautomationpractice
     [Tags]    testautomationpractice
     # Acessar a URL: https://testautomationpractice.blogspot.com/ 
     Open Browser  https://testautomationpractice.blogspot.com/  chrome
     sleep  3

Preencher Campo nome, email e telefone
     [Tags]    testautomationpractice
     
     Wait Until Element Is Enabled  xpath://input[@id="name"]
     Input Text  xpath://input[@id="name"]   ${Cadastro.nome}      # Preencha o campo "Nome"
     Input Text  xpath://input[@id="email"]  ${Cadastro.email}     # Preencha o campo "Email"
     Input Text  xpath://input[@id="phone"]  ${Cadastro.telefone}  # Preencha o campo "Phone"
     Input Text  xpath://textarea[@id="textarea"]  ${Cadastro.address}  # Preencha o campo "address"


 Preencher Radio buton gender
     [Tags]    testautomationpractice
     Select Radio Button    gender  ${gender}[0]  # O elemento radio sempre tem o mesmo "name", por isso "name" é o grupo mas com "values" diferentes.

     Radio Button Should Be Set To  gender  male  # group e value
     
Escolher 3 opções do campo "Days"
     [Tags]    testautomationpractice
     # Escolha 3 opções do campo "Days"
     Select Checkbox  //input[@id="${dias_da_semana}[1]"]  #sunday
     Select Checkbox  //input[@id="${dias_da_semana}[3]"]  #tuesday
     Select Checkbox  //input[@id="${dias_da_semana}[5]"]  #thursday

     Checkbox Should Be Selected  xpath://input[@id="sunday"]
     Checkbox Should Be Selected  xpath://input[@id="tuesday"]
     Checkbox Should Be Selected  xpath://input[@id="thursday"]

Escolher uma opção do campo "Country"
     [Tags]    testautomationpractice
     # Escolha uma opção do campo "Country"
     Select From List By Index    xpath://select[@id="country"]    0                 #Usa
     Select From List By Label    xpath://select[@id="country"]    United Kingdom    #United Kingdom
     Select From List By Value    xpath://select[@id="country"]    china             #China
     
     List Selection Should Be    xpath://select[@id="country"]    china    # Aqui só pode estar um selecionado, por isso apesar de ter marcado usa e United Kingdom, a úçtima selecao (China) é a que prevalece 

#                                                                        <div class="form-group">
#                                                                           <label for="country">Country:</label> <select class="form-control" id="country">
#                                                                              <option value="usa"> United States </option>
#                                                                              <option value="canada"> Canada </option>
#                                                                              <option value="uk"> United Kingdom </option>
#                                                                              <option value="germany"> Germany </option>
#                                                                              <option value="france"> France </option>
#                                                                              <option value="australia"> Australia </option>
#                                                                              <option value="japan"> Japan </option>
#                                                                              <option value="china"> China </option>
#                                                                              <option value="brazil"> Brazil </option>
#                                                                              <option value="india"> India </option>
#                                                                            </select>
#                                                                          </div>
    
  

Escolher 2 opções do campo "Colors"
     [Tags]    testautomationpractice
     # Escolha 2 opções do campo "Colors"
    Select From List By Index    xpath://select[@id="colors"]   0
    Select From List By Index    xpath://select[@id="colors"]   2

    List Selection Should Be     xpath://select[@id="colors"]    Red  Green  #Assim consigo fazer logo a validacao para as 2 selecoes

#                                                                          <div class="form-group">
#                                                                            <label for="colors">Colors:</label> <select class="form-control" id="colors" multiple="">
#                                                                               <option value="red"> Red </option>
#                                                                                     <option value="blue"> Blue </option>
#                                                                                     <option value="green"> Green </option>
#                                                                                     <option value="yellow"> Yellow </option>
#                                                                                     <option value="red"> Red </option>
#                                                                                     <option value="white"> White </option>
#                                                                                     <option value="green"> Green </option>
#                                                                                </select>
#                                                                           </div>


Escolher 2 opções do campo "Sorted List"
     [Tags]    testautomationpractice
     # Escolha 2/3 opções do campo "Sorted List"
                
    Click Element    //option[@value="cat"]
    Select From List By Value    xpath://select[@id="animals"]    deer   # Esta é a forma correta de fazer a seleção (Através de Select)
    Click Element    //option[@value="dog"]
    List Selection Should Be     xpath://select[@id="animals"]    cat  dog  deer  #Assim consigo fazer logo a validacao para as 2 selecoes

Preencha o campo "Date Picker 1:""
     [Tags]    testautomationpractice
     # Preencha o campo "Date Picker 1:"
    Input Text  xpath://input[@id="datepicker"]   29/01/2025
    Press Keys  xpath://input[@id="datepicker"]    ESCAPE

Preencher o campo "Date Picker 2"
    [Tags]    testautomationpractice
     # Preencha o campo "Date Picker 2"
    Click Element    //input[@id="txtDate"]  # 1) Clicar no campo data (para abrir o calendario)
    Select From List By Label   xpath://select[@aria-label="Select month"]  Mar  # 2) Escolher o campo de mes (Select combobox) 3=Apr
    Select From List By Label   xpath://select[@aria-label="Select year"]  2020  # 3) Escolher o campo de ano (Select combobox)
    #Click Element     //td[@data-handler="selectDay" and @data-month="2" and @data-year="2020"]/a[@class="ui-state-default" and text()="15"]   # 4) Clicar no campo data (importante perceber que o campo data esta relacionada com o mes e ano)
    Click Element     //a[@data-date="15"]   # 4) Clicar no campo data (Só funciona porque previamente já selecionei o mes e o ano)
    
Preencha o campo "Date Picker 3:"
     [Tags]    testautomationpractice
     # Preencha o campo "Date Picker 3:"

    Input Text  //input[@id="start-date"]   12-01-2024
    Input Text  //input[@id="end-date"]     12-15-2024

    # Se quisermos colocar a dada do sistema na segunda data
#     ${TODAY}    Get Current Date    result_format=%m-%d-%Y
#     Input Text  //input[@id="end-date"]     ${TODAY}  #12-15-2024

    # Clique no botão "Submit" da data.
    Click Button    //button[@class="submit-btn"]
    
     # Validar se no texto, abaixo do Range das datas, esta a quantidade de dias entre as datas escolhidas.
    Element Text Should Be  //div[text()="You selected a range of 14 days."]  You selected a range of 14 days.

Realizar um upload de um arquivo.
     [Tags]    testautomationpractice
     # Realizar um upload de um arquivo.
    Choose File  //input[@id="singleFileInput"]   C:\\000SAMNS\\Robot_Framework\\TesteUploadPDF.pdf

    # Se quisermos fazer upload de um ficheiro que esta na raiz do robot:
    Choose File  //input[@id="singleFileInput"]   ${EXECDIR}\\imagen.png
    sleep  10

Logar na aplicação saucedemo
     [Tags]    Saucedemo
     Acessar Aplicacao Saucedemo (com login e pass) 

Adicionar um produto ao carrinho
     [Tags]    Saucedemo
     # Logar na aplicação https://www.saucedemo.com/
     Acessar Aplicacao Saucedemo (com login e pass) 
     # Escolher um produto e clicar no botao "Add to cart"
     Click Link     //a[@id="item_4_title_link"]
     sleep  1
     Click Button    //button[@class="btn btn_primary btn_small btn_inventory"]

Entrar no carrinho (icone na parte superior direito) e validar
     [Tags]    Saucedemo
     # Entrar no carrinho (icone na parte superior direito)
     Click Link      //a[@data-test="shopping-cart-link"]
     # validar se o produto escolhido esta no carrinho
     Element Should Be Visible  //div[@data-test="inventory-item-name" and text()="Sauce Labs Backpack"]


Excluir um produto do carrinho
     [Tags]    Saucedemo
     # Logar na aplicação https://www.saucedemo.com/
     Acessar Aplicacao Saucedemo (com login e pass) 
             #Aqui adiciono um item
     Click Link     //a[@id="item_4_title_link"]
     sleep  1
     Click Button    //button[@class="btn btn_primary btn_small btn_inventory"]
    
     #Entrar no carrinho
     Click Link      //a[@data-test="shopping-cart-link"]
     # Excluir todos os produtos do carrinho
     sleep  3
     Click Button    //button[@id="remove-sauce-labs-backpack"]
     Element Should Not Be Visible    //div[@data-test="inventory-item-name" and text()="Sauce Labs Backpack"]
     # Obs: Senao houver produto, adicionar antes.



# Coloquei no git: https://github.com/SamOnGit/Robot_Web/blob/main/ex1_AutoTestes.robot
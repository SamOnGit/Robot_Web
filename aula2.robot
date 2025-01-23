*** Settings ***
Library  SeleniumLibrary


*** Keywords ***

*** Variables ***

*** Test Cases ***
Logar com user e password corretos
    # Abrir a aplicação
        Open Browser  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login  chrome

        #Abrir browser maximizado (com options)
        # Open Browser    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login    chrome    options=add_argument("--start-maximized")

    # Inserir Logine senha
        #Wait Until Element Is Enabled  xpath://input[@name="username"]  Admin
        sleep  5
        Input Text  xpath://input[@name="username"]  Admin
        Input Text  xpath://input[@name="password"]  admin123


Verificar que não estou logado
        Page Should Not Contain Element  xpath://img[@src="/web/images/orangehrm-logo.png?v=1721393199309"]


    # clicar no OK

        # Não é a forma correta de encontrar o elemento atraves de uma classe...
        #Click Element  //button[@class="oxd-button oxd-button--medium oxd-button--main orangehrm-login-button"]

        # Assim fica melhor
        Click Element  xpath://button[text()=" Login "]

        # podia ser tambem:, mas não está a fincionar...
        # //button[contains(text()," Login ")]

        # podia ser tambem assim
        #Click Element  xpath://button[text()=" Login "]
    
        Sleep  2

    # Validar se estou logado


Verificar que estou logado
       Page Should Contain Image  //img[@src="/web/images/orangehrm-logo.png?v=1721393199309"]


#Analisando Variaveis
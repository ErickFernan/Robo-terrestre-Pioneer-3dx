# Robô terrestre Pioneer 3dx
 Este diretório contém alguns projetos relacionados ao robô Pionner 3dx assim como as ferramentas necessárias para seu funcionamento.
 
<p align="center">
 <img src="https://user-images.githubusercontent.com/96123177/157431497-3ed533cf-1f91-429e-8072-5554e1a2a633.gif?raw=true" alt="Sublime's custom image"/>
</p>

O GIF acima demonstra o funcionamento da estratégia de controle para desvio reativo usando a estratégia de campos potenciais. Para mais detalhes [CLique aqui](https://drive.google.com/drive/u/3/folders/13g316Hx4Hmsa8QIb1kfIOlRtbNrYUDY-).


## Para reproduzir e editar o códido do controlador siga os passos abaixo:

1. Tenha instalado o Matlab e o [Coppelia Robotics](https://www.coppeliarobotics.com/downloads) (Antigo V-Rep)

2. Faça o download deste diretório. É importante que as pastas contendo as funções VREP e API estejam no mesmo local, pois do contrário a comunicação entre o MATLAB e o Coppelia Robotics não acontecerá.

3. Abra os arquivos 'cenario_desvio.ttt' que se encontra na pasta Scene e 'DesvioPotencial_VRep.m' na pasta main.

4. Inicie a simulação no Coppelia Robotics.

5. Inicie o controlador no Matlab.

7. É possível que sejam necessário alguns ajustes de ganhos no controlador, faça-o para melhor resultado.


# Aplicando controladores no robô pioneer 3dx real

<p align="justify"> 
 Desenvolvido pelo Núcleo de Especialzação em Róbotica (NERO) a AuRoRa é uma plataforma para aplicações na área de robótica.
 </p>
 
Caso queira testar seus própios controladores isso se torna possível ao se baixar o arquivo [pioneer 3dx](https://github.com/ErickFernan/AuRoRa/tree/main/AuRoRA-master/AuRoRA-2018/pioneer%203dx).

<p align="justify"> 
 Este diretório contém toda a parte reponsável pela comunicação entre o Matlab e o robô, sendo preciso apenas utilizar as funções que necessitar e implementar seu controlador.  Caso não possua o robô a plataforma contém um modelo para simulação, sendo necessário apenas o matlab para desenvolvimento de projetos, veja um exemplo abaixo:
</p>

<p align="center">
 <img src="https://user-images.githubusercontent.com/96123177/157440615-8b7e7939-4b88-465b-b017-f927511803c6.gif?raw=true" alt="Sublime's custom image"/>
</p>


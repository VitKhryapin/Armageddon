# Armageddon

### Application
Приложение показывающие подлет астероидов к земле от текущей даты в бесконечность (API NASA).

### Preview App
<img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/1shot.png" width="150"> <img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/MainView.png" width="150"> <img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/DetailAlert.png" width="150"> <img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/FilterView.png" width="150"> <img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/TrashView.png" width="150"><img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/2TrashView.png" width="150"> <img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/FinishComand.png" width="150"> 

### Functionality
+ Данные подгружаются порциями (по одному дню при скроле)
+ Размер астеройда изменяется в зависимости от его размера
+ Цвет градиента изменяется в зависимости от опасности 
+ Более подробная информация по астеройду выводится при клике на астеройд (из алерта есть возможность добавлять астеройд в список на уничтожение)
+ Созданы настройки в которых можно изменить единицы измерения расстояния и отфильтровать только опасные астеройды (настройки сохраняются в UserDefaults)
+ При нажатии на кнопку "Унижтожение" данный астеройд добавляется в список на уничтожение
+ Переход в список на уничтожение реализован с помощью TabBar
+ При клике на астеройд в списке на уничтожение также выводится подробная информация
+ При свайпе влево можно убрать астеройд из списка на уничтожение
+ При нажатии на кнопку отправить команду Брюса Улиса, команда спасает планету)

*P.S.: в проекте стороние библиотеки не используются, проект запускается из коробки* 

### Stack
+ Swift.
+ UIKit.
+ MVP
+ XIB.
+ Auto Layout.
+ URLSession.
+ Codable.
+ API NASA.
+ XCTests



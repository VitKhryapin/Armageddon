# Armageddon

### Application
Приложение показывающие подлет астероидов к земле от текущей даты в бесконечность (API NASA).

### Preview App
<img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/1shot.png" width="150"> <img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/MainView.png" width="150"> <img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/DetailAlert.png" width="150"> <img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/FilterView.png" width="150"> <img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/TrashView.png" width="150"><img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/2TrashView.png" width="150"> <img src="https://github.com/VitKhryapin/Armageddon/blob/main/Preview/FinishComand.png" width="150"> 

### Functionality
+ Данные подгружаются порциями (по одному дню при скроле)
+ Размер астероида изменяется в зависимости от его размера
+ Цвет градиента изменяется в зависимости от опасности 
+ Более подробная информация по астероиду выводится при клике на астероид (из алерта есть возможность добавлять астероид в список на уничтожение)
+ Созданы настройки в которых можно изменить единицы измерения расстояния и отфильтровать только опасные астероиды (настройки сохраняются в UserDefaults)
+ При нажатии на кнопку "Унижтожение" данный астероид добавляется в список на уничтожение
+ Переход в список на уничтожение реализован с помощью TabBar
+ При клике на астероид в списке на уничтожение также выводится подробная информация
+ При свайпе влево можно убрать астероид из списка на уничтожение
+ При нажатии на кнопку отправить команду Брюса Уилиса, команда спасает планету)
+ Обработка ошибок при отсутствии сети

*P.S.: в проекте сторонние библиотеки не используются, проект запускается из коробки* 

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



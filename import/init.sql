create database magnet collate 'utf8_general_ci';
create user magnet@localhost identified by 'magnet';
grant all on magnet.* to magnet@localhost;

use magnet;

create table torrents(
    tid int primary key auto_increment,
    name varchar(256) not null,
    magnet char(40) unique
);

create table GrogMethod
(
   ClassName   char(30),
   Name   char(30),
   MethodType   char(30)
)
/
create view GrogClass as
   select view_name Name from user_views
/
create public synonym grogmethod for grogmethod
/
create public synonym grogclass for grogclass
/
quit
/

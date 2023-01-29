use Traffic
go
--������ͼ���ֱ���ʾָ���Ĵ�����ʽ��Υ�´�����Ϣ
create view panish_warning
as
	select carId, licenseId, punishTime, punishAddr,
			punishWay, fine, punishState
	from  Notification a, Punishiment b, Include c
	where  a.notificationId = c.notificationId 
	       and b.punishId = c.punishId
		   and punishWay = '����'
go

create view panish_fine
as
	select carId, licenseId, punishTime, punishAddr,
			punishWay, fine, punishState
	from  Notification a, Punishiment b, Include c
	where  a.notificationId = c.notificationId 
	       and b.punishId = c.punishId
		   and punishWay = '����'
go

create view panish_score
as
	select carId, licenseId, punishTime, punishAddr,
			punishWay, fine, punishState
	from  Notification a, Punishiment b, Include c
	where  a.notificationId = c.notificationId 
	       and b.punishId = c.punishId
		   and punishWay = '�۷�'
go

create view panish_hold
as
	select carId, licenseId, punishTime, punishAddr,
			punishWay, fine, punishState
	from  Notification a, Punishiment b, Include c
	where  a.notificationId = c.notificationId 
	       and b.punishId = c.punishId
		   and punishWay = '�ݿۼ�ʻִ��'
go



use Traffic
go
--�����洢���̣����복���պţ���ʾδ�����Υ�·����������Ϣ
if exists(select name from sysobjects where name='driver_punish_todo' and type='p')
	drop procedure driver_punish_todo
go
create procedure driver_punish_todo(@carid char(12))
as
	select carId, licenseId, punishTime, punishAddr,
			punishWay, fine, punishState
	from  Notification a, Punishiment b, Include c
	where  a.notificationId = c.notificationId 
	       and b.punishId = c.punishId
		   and carId = @carid
		   and punishState = 'δ����'
go

--�����洢���̣����뾯�ţ���ʾ�þ��쾭���δ�����Υ�·����������Ϣ
if exists(select name from sysobjects where name='police_punish_todo' and type='p')
	drop procedure police_punish_todo
go
create procedure police_punish_todo(@policeid char(12))
as
	select policeId, carId, licenseId, punishTime, punishAddr,
			punishWay, fine, punishState
	from  Notification a, Punishiment b, Include c
	where  a.notificationId = c.notificationId 
	       and b.punishId = c.punishId
		   and policeId = @policeid
		   and punishState = 'δ����'
go



use Traffic
go
--ΪNotification��������ʱ�併������ķǾ۴�����
create unique nonclustered
index noti_time
on Notification(punishTime desc)
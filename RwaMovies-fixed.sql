CREATE DATABASE RWAMovies
GO
USE RWAMovies
GO

CREATE TABLE [dbo].[Country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [char](2) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
GO

CREATE TABLE [dbo].[Genre](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](1024) NULL,
	CONSTRAINT [PK_Genre] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
GO

CREATE TABLE [dbo].[Image](
	[Id] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
GO

CREATE TABLE [dbo].[Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[ReceiverEmail] [nvarchar](256) NOT NULL,
	[Subject] [nvarchar](256) NULL,
	[Body] [nvarchar](1024) NOT NULL,
	[SentAt] [datetime2](7) NULL,
	CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
GO

CREATE TABLE [dbo].[Tag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
GO

CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[DeletedAt] [datetime2](7) NULL,
	[Username] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](256) NOT NULL,
	[LastName] [nvarchar](256) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[PwdHash] [nvarchar](256) NOT NULL,
	[PwdSalt] [nvarchar](256) NOT NULL,
	[Phone] [nvarchar](256) NULL,
	[IsConfirmed] [bit] NOT NULL,
	[SecurityToken] [nvarchar](256) NULL,
	[CountryOfResidenceId] [int] NOT NULL,
	CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
GO

CREATE TABLE [dbo].[Video](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](1024) NULL,
	[GenreId] [int] NOT NULL,
	[TotalSeconds] [int] NOT NULL,
	[StreamingUrl] [nvarchar](256) NULL,
	[ImageId] [int] NULL,
	CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
GO

CREATE TABLE [dbo].[VideoTag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VideoId] [int] NOT NULL,
	[TagId] [int] NOT NULL,
	CONSTRAINT [PK_VideoTag] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
GO

ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsConfirmed]  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[Video] ADD  CONSTRAINT [DF_Video_CreatedAt]  DEFAULT (getutcdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Video] ADD  CONSTRAINT [DF_Video_TotalSeconds]  DEFAULT ((0)) FOR [TotalSeconds]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Country] FOREIGN KEY([CountryOfResidenceId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Country]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD  CONSTRAINT [FK_Video_Genre] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genre] ([Id])
GO
ALTER TABLE [dbo].[Video] CHECK CONSTRAINT [FK_Video_Genre]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD  CONSTRAINT [FK_Video_Images] FOREIGN KEY([ImageId])
REFERENCES [dbo].[Image] ([Id])
GO
ALTER TABLE [dbo].[Video] CHECK CONSTRAINT [FK_Video_Images]
GO
ALTER TABLE [dbo].[VideoTag]  WITH CHECK ADD  CONSTRAINT [FK_VideoTag_Tag] FOREIGN KEY([TagId])
REFERENCES [dbo].[Tag] ([Id])
GO
ALTER TABLE [dbo].[VideoTag] CHECK CONSTRAINT [FK_VideoTag_Tag]
GO
ALTER TABLE [dbo].[VideoTag]  WITH CHECK ADD  CONSTRAINT [FK_VideoTag_Video] FOREIGN KEY([VideoId])
REFERENCES [dbo].[Video] ([Id])
GO
ALTER TABLE [dbo].[VideoTag] CHECK CONSTRAINT [FK_VideoTag_Video]
GO

SET IDENTITY_INSERT dbo.country ON

INSERT INTO dbo.Country (id, code, name) VALUES
(1, 'AF', 'Afghanistan'),
(2, 'AL', 'Albania'),
(3, 'DZ', 'Algeria'),
(4, 'DS', 'American Samoa'),
(5, 'AD', 'Andorra'),
(6, 'AO', 'Angola'),
(7, 'AI', 'Anguilla'),
(8, 'AQ', 'Antarctica'),
(9, 'AG', 'Antigua and Barbuda'),
(10, 'AR', 'Argentina'),
(11, 'AM', 'Armenia'),
(12, 'AW', 'Aruba'),
(13, 'AU', 'Australia'),
(14, 'AT', 'Austria'),
(15, 'AZ', 'Azerbaijan'),
(16, 'BS', 'Bahamas'),
(17, 'BH', 'Bahrain'),
(18, 'BD', 'Bangladesh'),
(19, 'BB', 'Barbados'),
(20, 'BY', 'Belarus'),
(21, 'BE', 'Belgium'),
(22, 'BZ', 'Belize'),
(23, 'BJ', 'Benin'),
(24, 'BM', 'Bermuda'),
(25, 'BT', 'Bhutan'),
(26, 'BO', 'Bolivia'),
(27, 'BA', 'Bosnia and Herzegovina'),
(28, 'BW', 'Botswana'),
(29, 'BV', 'Bouvet Island'),
(30, 'BR', 'Brazil'),
(31, 'IO', 'British Indian Ocean Territory'),
(32, 'BN', 'Brunei Darussalam'),
(33, 'BG', 'Bulgaria'),
(34, 'BF', 'Burkina Faso'),
(35, 'BI', 'Burundi'),
(36, 'KH', 'Cambodia'),
(37, 'CM', 'Cameroon'),
(38, 'CA', 'Canada'),
(39, 'CV', 'Cape Verde'),
(40, 'KY', 'Cayman Islands'),
(41, 'CF', 'Central African Republic'),
(42, 'TD', 'Chad'),
(43, 'CL', 'Chile'),
(44, 'CN', 'China'),
(45, 'CX', 'Christmas Island'),
(46, 'CC', 'Cocos (Keeling) Islands'),
(47, 'CO', 'Colombia'),
(48, 'KM', 'Comoros'),
(49, 'CG', 'Congo'),
(50, 'CK', 'Cook Islands'),
(51, 'CR', 'Costa Rica'),
(52, 'HR', 'Croatia (Hrvatska)'),
(53, 'CU', 'Cuba'),
(54, 'CY', 'Cyprus'),
(55, 'CZ', 'Czech Republic'),
(56, 'DK', 'Denmark'),
(57, 'DJ', 'Djibouti'),
(58, 'DM', 'Dominica'),
(59, 'DO', 'Dominican Republic'),
(60, 'TP', 'East Timor'),
(61, 'EC', 'Ecuador'),
(62, 'EG', 'Egypt'),
(63, 'SV', 'El Salvador'),
(64, 'GQ', 'Equatorial Guinea'),
(65, 'ER', 'Eritrea'),
(66, 'EE', 'Estonia'),
(67, 'ET', 'Ethiopia'),
(68, 'FK', 'Falkland Islands (Malvinas)'),
(69, 'FO', 'Faroe Islands'),
(70, 'FJ', 'Fiji'),
(71, 'FI', 'Finland'),
(72, 'FR', 'France'),
(73, 'FX', 'France, Metropolitan'),
(74, 'GF', 'French Guiana'),
(75, 'PF', 'French Polynesia'),
(76, 'TF', 'French Southern Territories'),
(77, 'GA', 'Gabon'),
(78, 'GM', 'Gambia'),
(79, 'GE', 'Georgia'),
(80, 'DE', 'Germany'),
(81, 'GH', 'Ghana'),
(82, 'GI', 'Gibraltar'),
(83, 'GK', 'Guernsey'),
(84, 'GR', 'Greece'),
(85, 'GL', 'Greenland'),
(86, 'GD', 'Grenada'),
(87, 'GP', 'Guadeloupe'),
(88, 'GU', 'Guam'),
(89, 'GT', 'Guatemala'),
(90, 'GN', 'Guinea'),
(91, 'GW', 'Guinea-Bissau'),
(92, 'GY', 'Guyana'),
(93, 'HT', 'Haiti'),
(94, 'HM', 'Heard and Mc Donald Islands'),
(95, 'HN', 'Honduras'),
(96, 'HK', 'Hong Kong'),
(97, 'HU', 'Hungary'),
(98, 'IS', 'Iceland'),
(99, 'IN', 'India'),
(100, 'IM', 'Isle of Man'),
(101, 'ID', 'Indonesia'),
(102, 'IR', 'Iran (Islamic Republic of)'),
(103, 'IQ', 'Iraq'),
(104, 'IE', 'Ireland'),
(105, 'IL', 'Israel'),
(106, 'IT', 'Italy'),
(107, 'CI', 'Ivory Coast'),
(108, 'JE', 'Jersey'),
(109, 'JM', 'Jamaica'),
(110, 'JP', 'Japan'),
(111, 'JO', 'Jordan'),
(112, 'KZ', 'Kazakhstan'),
(113, 'KE', 'Kenya'),
(114, 'KI', 'Kiribati'),
(115, 'KP', 'Korea, Democratic People''s Republic of'),
(116, 'KR', 'Korea, Republic of'),
(117, 'XK', 'Kosovo'),
(118, 'KW', 'Kuwait'),
(119, 'KG', 'Kyrgyzstan'),
(120, 'LA', 'Lao People''s Democratic Republic'),
(121, 'LV', 'Latvia'),
(122, 'LB', 'Lebanon'),
(123, 'LS', 'Lesotho'),
(124, 'LR', 'Liberia'),
(125, 'LY', 'Libyan Arab Jamahiriya'),
(126, 'LI', 'Liechtenstein'),
(127, 'LT', 'Lithuania'),
(128, 'LU', 'Luxembourg'),
(129, 'MO', 'Macau'),
(130, 'MK', 'Macedonia'),
(131, 'MG', 'Madagascar'),
(132, 'MW', 'Malawi'),
(133, 'MY', 'Malaysia'),
(134, 'MV', 'Maldives'),
(135, 'ML', 'Mali'),
(136, 'MT', 'Malta'),
(137, 'MH', 'Marshall Islands'),
(138, 'MQ', 'Martinique'),
(139, 'MR', 'Mauritania'),
(140, 'MU', 'Mauritius'),
(141, 'TY', 'Mayotte'),
(142, 'MX', 'Mexico'),
(143, 'FM', 'Micronesia, Federated States of'),
(144, 'MD', 'Moldova, Republic of'),
(145, 'MC', 'Monaco'),
(146, 'MN', 'Mongolia'),
(147, 'ME', 'Montenegro'),
(148, 'MS', 'Montserrat'),
(149, 'MA', 'Morocco'),
(150, 'MZ', 'Mozambique'),
(151, 'MM', 'Myanmar'),
(152, 'NA', 'Namibia'),
(153, 'NR', 'Nauru'),
(154, 'NP', 'Nepal'),
(155, 'NL', 'Netherlands'),
(156, 'AN', 'Netherlands Antilles'),
(157, 'NC', 'New Caledonia'),
(158, 'NZ', 'New Zealand'),
(159, 'NI', 'Nicaragua'),
(160, 'NE', 'Niger'),
(161, 'NG', 'Nigeria'),
(162, 'NU', 'Niue'),
(163, 'NF', 'Norfolk Island'),
(164, 'MP', 'Northern Mariana Islands'),
(165, 'NO', 'Norway'),
(166, 'OM', 'Oman'),
(167, 'PK', 'Pakistan'),
(168, 'PW', 'Palau'),
(169, 'PS', 'Palestine'),
(170, 'PA', 'Panama'),
(171, 'PG', 'Papua New Guinea'),
(172, 'PY', 'Paraguay'),
(173, 'PE', 'Peru'),
(174, 'PH', 'Philippines'),
(175, 'PN', 'Pitcairn'),
(176, 'PL', 'Poland'),
(177, 'PT', 'Portugal'),
(178, 'PR', 'Puerto Rico'),
(179, 'QA', 'Qatar'),
(180, 'RE', 'Reunion'),
(181, 'RO', 'Romania'),
(182, 'RU', 'Russian Federation'),
(183, 'RW', 'Rwanda'),
(184, 'KN', 'Saint Kitts and Nevis'),
(185, 'LC', 'Saint Lucia'),
(186, 'VC', 'Saint Vincent and the Grenadines'),
(187, 'WS', 'Samoa'),
(188, 'SM', 'San Marino'),
(189, 'ST', 'Sao Tome and Principe'),
(190, 'SA', 'Saudi Arabia'),
(191, 'SN', 'Senegal'),
(192, 'RS', 'Serbia'),
(193, 'SC', 'Seychelles'),
(194, 'SL', 'Sierra Leone'),
(195, 'SG', 'Singapore'),
(196, 'SK', 'Slovakia'),
(197, 'SI', 'Slovenia'),
(198, 'SB', 'Solomon Islands'),
(199, 'SO', 'Somalia'),
(200, 'ZA', 'South Africa'),
(201, 'GS', 'South Georgia South Sandwich Islands'),
(202, 'ES', 'Spain'),
(203, 'LK', 'Sri Lanka'),
(204, 'SH', 'St. Helena'),
(205, 'PM', 'St. Pierre and Miquelon'),
(206, 'SD', 'Sudan'),
(207, 'SR', 'Suriname'),
(208, 'SJ', 'Svalbard and Jan Mayen Islands'),
(209, 'SZ', 'Swaziland'),
(210, 'SE', 'Sweden'),
(211, 'CH', 'Switzerland'),
(212, 'SY', 'Syrian Arab Republic'),
(213, 'TW', 'Taiwan'),
(214, 'TJ', 'Tajikistan'),
(215, 'TZ', 'Tanzania, United Republic of'),
(216, 'TH', 'Thailand'),
(217, 'TG', 'Togo'),
(218, 'TK', 'Tokelau'),
(219, 'TO', 'Tonga'),
(220, 'TT', 'Trinidad and Tobago'),
(221, 'TN', 'Tunisia'),
(222, 'TR', 'Turkey'),
(223, 'TM', 'Turkmenistan'),
(224, 'TC', 'Turks and Caicos Islands'),
(225, 'TV', 'Tuvalu'),
(226, 'UG', 'Uganda'),
(227, 'UA', 'Ukraine'),
(228, 'AE', 'United Arab Emirates'),
(229, 'GB', 'United Kingdom'),
(230, 'US', 'United States'),
(231, 'UM', 'United States minor outlying islands'),
(232, 'UY', 'Uruguay'),
(233, 'UZ', 'Uzbekistan'),
(234, 'VU', 'Vanuatu'),
(235, 'VA', 'Vatican City State'),
(236, 'VE', 'Venezuela'),
(237, 'VN', 'Vietnam'),
(238, 'VG', 'Virgin Islands (British)'),
(239, 'VI', 'Virgin Islands (U.S.)'),
(240, 'WF', 'Wallis and Futuna Islands'),
(241, 'EH', 'Western Sahara'),
(242, 'YE', 'Yemen'),
(243, 'ZR', 'Zaire'),
(244, 'ZM', 'Zambia'),
(245, 'ZW', 'Zimbabwe');
 
SET IDENTITY_INSERT country OFF
 
GO

SET IDENTITY_INSERT dbo.Genre ON

insert into dbo.Genre (Id, Name, Description) values (1, 'Musical', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into dbo.Genre (Id, Name, Description) values (2, 'Drama', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into dbo.Genre (Id, Name, Description) values (3, 'Adventure', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into dbo.Genre (Id, Name, Description) values (4, 'Action|Adventure|Animation|Children|Comedy|Fantasy', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into dbo.Genre (Id, Name, Description) values (5, 'Drama|Horror|Mystery', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into dbo.Genre (Id, Name, Description) values (6, 'Action|Crime|Horror|Thriller', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into dbo.Genre (Id, Name, Description) values (7, 'Action|Adventure', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into dbo.Genre (Id, Name, Description) values (8, 'Action|Crime|Drama', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into dbo.Genre (Id, Name, Description) values (9, 'Drama|Romance', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into dbo.Genre (Id, Name, Description) values (10, 'Drama', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into dbo.Genre (Id, Name, Description) values (11, 'Drama', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into dbo.Genre (Id, Name, Description) values (12, 'Comedy', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into dbo.Genre (Id, Name, Description) values (13, 'Action|Adventure|Crime|Drama|Sci-Fi|Thriller|War', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into dbo.Genre (Id, Name, Description) values (14, 'Comedy|Romance|Thriller', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into dbo.Genre (Id, Name, Description) values (15, 'Comedy|Drama', 'In congue. Etiam justo. Etiam pretium iaculis justo.');

SET IDENTITY_INSERT dbo.Genre OFF

GO

SET IDENTITY_INSERT dbo.Notification ON

insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (1, '9/6/2023', 'mholburn0@hostgator.com', 'in faucibus orci luctus', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '11/12/2022');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (2, '3/12/2023', 'sbarles1@usatoday.com', 'dolor vel', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '12/14/2022');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (3, '6/10/2023', 'bkeyworth2@irs.gov', 'et', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '7/16/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (4, '10/11/2022', 'dsharvell3@gov.uk', 'consequat', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', '5/1/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (5, '8/24/2023', 'ebenoi4@technorati.com', 'nec condimentum neque', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', '3/23/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (6, '10/17/2022', 'ckidstoun5@pagesperso-orange.fr', 'lorem id', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '6/24/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (7, '3/21/2023', 'agobert6@instagram.com', 'duis mattis egestas', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', '11/29/2022');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (8, '12/20/2022', 'greinhard7@qq.com', 'lorem vitae mattis nibh ligula', 'In congue. Etiam justo. Etiam pretium iaculis justo.', '12/14/2022');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (9, '2/1/2023', 'cgilliat8@squidoo.com', 'ipsum primis in', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', '10/2/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (10, '7/12/2023', 'elawes9@seattletimes.com', 'mauris viverra', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '6/4/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (11, '1/4/2023', 'handora@dmoz.org', 'posuere cubilia curae nulla', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '8/7/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (12, '9/3/2023', 'lszachb@tumblr.com', 'dui vel nisl duis', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '8/7/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (13, '8/19/2023', 'sgraffinc@dailymotion.com', 'integer tincidunt ante vel ipsum', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', '3/29/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (14, '8/3/2023', 'bclewarthd@disqus.com', 'nec sem', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', '11/30/2022');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (15, '7/28/2023', 'lflintoffee@newyorker.com', 'augue aliquam erat volutpat in', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', '7/27/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (16, '6/10/2023', 'dpaolozzif@opera.com', 'ac enim in tempor turpis', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '7/10/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (17, '10/2/2023', 'efullg@blog.com', 'at dolor', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', '11/14/2022');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (18, '10/19/2022', 'cphaliph@icio.us', 'bibendum imperdiet nullam', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '12/23/2022');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (19, '4/2/2023', 'abraunesi@ifeng.com', 'nonummy', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '2/12/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (20, '9/27/2023', 'mkermanj@elegantthemes.com', 'urna ut', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '2/1/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (21, '3/27/2023', 'dthewk@nationalgeographic.com', 'elementum', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', '4/29/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (22, '9/23/2023', 'frennisonl@cnn.com', 'elementum', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '12/7/2022');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (23, '8/24/2023', 'dbaterm@ifeng.com', 'in libero ut massa', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '11/22/2022');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (24, '11/18/2022', 'bklauern@symantec.com', 'luctus et ultrices', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', '1/9/2023');
insert into dbo.Notification (Id, CreatedAt, ReceiverEmail, Subject, Body, SentAt) values (25, '10/31/2022', 'wdenerso@a8.net', 'integer ac leo pellentesque ultrices', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '1/31/2023');


SET IDENTITY_INSERT dbo.Notification OFF

GO

SET IDENTITY_INSERT dbo.Tag ON

insert into dbo.Tag (Id, Name) values (1, 'Integrated');
insert into dbo.Tag (Id, Name) values (2, 'synergy');
insert into dbo.Tag (Id, Name) values (3, 'Cloned');
insert into dbo.Tag (Id, Name) values (4, 'directional');
insert into dbo.Tag (Id, Name) values (5, 'Operative');
insert into dbo.Tag (Id, Name) values (6, 'attitude');
insert into dbo.Tag (Id, Name) values (7, 'Organic');
insert into dbo.Tag (Id, Name) values (8, 'intangible');
insert into dbo.Tag (Id, Name) values (9, 'Organized');
insert into dbo.Tag (Id, Name) values (10, 'synergy');
insert into dbo.Tag (Id, Name) values (11, 'asymmetric');
insert into dbo.Tag (Id, Name) values (12, 'Object-based');
insert into dbo.Tag (Id, Name) values (13, 'bi-directional');
insert into dbo.Tag (Id, Name) values (14, 'context-sensitive');
insert into dbo.Tag (Id, Name) values (15, 'fault-tolerant');
insert into dbo.Tag (Id, Name) values (16, 'systemic');
insert into dbo.Tag (Id, Name) values (17, 'service-desk');
insert into dbo.Tag (Id, Name) values (18, 'firmware');
insert into dbo.Tag (Id, Name) values (19, '24 hour');
insert into dbo.Tag (Id, Name) values (20, 'product');
insert into dbo.Tag (Id, Name) values (21, 'infrastructure');
insert into dbo.Tag (Id, Name) values (22, 'asynchronous');
insert into dbo.Tag (Id, Name) values (23, 'local');
insert into dbo.Tag (Id, Name) values (24, 'secured line');
insert into dbo.Tag (Id, Name) values (25, 'bandwidth-monitored');
insert into dbo.Tag (Id, Name) values (26, 'content-based');
insert into dbo.Tag (Id, Name) values (27, 'intermediate');
insert into dbo.Tag (Id, Name) values (28, 'intangible');
insert into dbo.Tag (Id, Name) values (29, 'alliance');
insert into dbo.Tag (Id, Name) values (30, 'Multi-channelled');

SET IDENTITY_INSERT dbo.Tag OFF

GO

insert into dbo.Image (Id, Content) values (1, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAIsSURBVDjLpVNLSJQBEP7+h6uu62vLVAJDW1KQTMrINQ1vPQzq1GOpa9EppGOHLh0kCEKL7JBEhVCHihAsESyJiE4FWShGRmauu7KYiv6Pma+DGoFrBQ7MzGFmPr5vmDFIYj1mr1WYfrHPovA9VVOqbC7e/1rS9ZlrAVDYHig5WB0oPtBI0TNrUiC5yhP9jeF4X8NPcWfopoY48XT39PjjXeF0vWkZqOjd7LJYrmGasHPCCJbHwhS9/F8M4s8baid764Xi0Ilfp5voorpJfn2wwx/r3l77TwZUvR+qajXVn8PnvocYfXYH6k2ioOaCpaIdf11ivDcayyiMVudsOYqFb60gARJYHG9DbqQFmSVNjaO3K2NpAeK90ZCqtgcrjkP9aUCXp0moetDFEeRXnYCKXhm+uTW0CkBFu4JlxzZkFlbASz4CQGQVBFeEwZm8geyiMuRVntzsL3oXV+YMkvjRsydC1U+lhwZsWXgHb+oWVAEzIwvzyVlk5igsi7DymmHlHsFQR50rjl+981Jy1Fw6Gu0ObTtnU+cgs28AKgDiy+Awpj5OACBAhZ/qh2HOo6i+NeA73jUAML4/qWux8mt6NjW1w599CS9xb0mSEqQBEDAtwqALUmBaG5FV3oYPnTHMjAwetlWksyByaukxQg2wQ9FlccaK/OXA3/uAEUDp3rNIDQ1ctSk6kHh1/jRFoaL4M4snEMeD73gQx4M4PsT1IZ5AfYH68tZY7zv/ApRMY9mnuVMvAAAAAElFTkSuQmCC');
insert into dbo.Image (Id, Content) values (2, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAH/SURBVDjLjZPNaxNRFMWrf4cFwV13JVKXLuta61apIChIV0rblUqhjYpRcUaNboxIqxFTQgVti4hQQTe1C7FFSUmnmvmM85XJzCSpx3efzmTSRtqBw7yZ9+5v7rl3bg+AHhK7DjClmAZ20UGm/XFcApAKgsBqNptbrVYL3cT2IQjCnSQkCRig4FqtBs/zYtm2DdM0oaoqh8iyDFEUY0gUvI8AdMD3fYRhyO8k13VhWRY0TeOAer0O+kg2m/0LIcDx9LdDgxff5jJzKjJzCmbe6fi0anEABTiOA13Xd1jiNTlxfT01UVB/CfMG7r/WILxScaOo4FpeBrPEfUdWDMPgmVQqlTbgtCjls4sGjl16PxuRny5oGH3yA7oZoPjR4BDbqeHlksLrUa1W24DJWRU3Wer9Qw/Gk+kVmA2lGuDKtMQzsVwfl6c3eE3IUgyYeCFjsqCgb3DqQhJwq/gTY7lyV61Jdhtw7qFUSjNA/8m8kASkc5tYXnN4BvTs1kO23uAdIksx4OjI19Grzys4c7fkfCm5MO0QU483cf5eGcurNq8BWfD8kK11HtwBoDYeGV4ZO5X57ow8knBWLGP49jqevVF5IKnRaOxQByD6kT6smFj6bHb0OoJsV1cAe/n7f3PQRVsx4B/kMCuQRxt7CWZnXT69CUAvQfYwzpFo9Hv/AD332dKni9XnAAAAAElFTkSuQmCC');
insert into dbo.Image (Id, Content) values (3, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAImSURBVDjLpZPfa1JhGMcHXfZ/eBUVdNOVBqGDgwaSy1HLg6R5IUVyYCi5li6Wv+dRysAQoiG4ple1aMyRYj/wF8Ugl8PVTSCM0GI0K/DbeR9RJ4xi9MLnnPf9Pg+f877ncMYAjP0PdOGjVZtEWKIsAT5a6fKRCvhwGUbpfiVagVEsgQ+VWqZIseTPbMK/XMN+QRyHHN6lDyOCTbZ6WPg6IP4X2DAGXneGArHS7gty9V0iv3UwfcHknVx3IDCEy79YGP/Hk/fvQO9aHx7hcqjUPew7mLi1NhRMBYoU6mbXoJ5ZBedcpfX2l/aBUK/zxVBwyfeWwjPTzzGXfI/TwspAsNP6MUJfcN6+MhRc9Lyh8NT1p7j5qAjOKiIYDCKRSMDr86H8roatz034/QHKWG3qhgi5XH60t4P5VyQ4dnUZvHAXoiii2Wyi0Wggl8shtBDGvfsP8LFep6xQKFCPWq329XYwXyDB8QseCNN2VDc24PF4oNFoYDabEYlE4HA4aM4yVmMSQRDaJJh05+krnOCsmHXNkaDT6UA1Po5sNotqtYp8Po90Ok0ZqzGB2+3eI8HE7ZfbTJBKpWCz2UjgcrmgVCqhUqmg1WoJNmcZqzGBxWJp9QQz6ws6Z/aZ+trjb+d0BngDYSwmnyCTySAWi5HUbrfTnGWLyaWuLxD6LR2nNvJrymSyIwqF4iTHcZ9MJtOu1Wrdk/ip1+sNEmel+XeWsRrrYb1/AB4L/elcpleiAAAAAElFTkSuQmCC');
insert into dbo.Image (Id, Content) values (4, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAANpSURBVDjLfdPdb1N1AMbx5/ScvtHTZbSwDcrWlXXIUOdkZiRmioQXSYgX82p4YUKMkJjswpkRjCJckUWDhBCZGoJhYrwYMIUQzbhReZOZLtvqateVgdKVjYV2W3t+b+fl5wWSwI3fP+CT5+ZRpJR43LHkYZ1bopsJsZMJ2sYEB+NsmDLxkyo2HamUnd7Pd0cInkh5DBwdP7SZm+KbjZXtMVXzwVRsVPlXYiqXwoWJ7/siypdJYVo9Qth7Tu1t+PUp4LOxgx117viFcGA1ZsRDjJZTUKULL+sv4rvfvy74rY62oLJtuC2uhybuLuHv++U3B/Y3DwKA69PRgyEmWH+VXoeRcga/LdzEgrmIuD+Kudl7MAz6cUBu/WBdlS9UvdyHxlU6KBX9Ow7cCAGAi3Da3Vq5Wc/SHFJkEsRiWKmGoDM3fhg/NxpRT9xi1Nwbrw0gnWcIVXjRuCaoM0K7/wOMXarbi2Q5DWFxVLh0NFesx3DmOmiJdZlcO96yNqgK00HuoUBmlqMmHACjbBcAaISyDVyx4IKCFv051Hsj+Gc6i0Q2cToW7F9NKW+NhP24mSEghg1jyUZTxA3OaAwANIMSWu1b4WkPvoS5/D30jRwtcEMcP1R84+TkYkIbCjyTfVBkz2tQQAwH0nHAhQZBmfpoAaF3/vjrRsulPwfnOeW9+++vGdhaCLwtycTkKyTx2qUNPWDcBiES1LARXu7GzIMyBKfZR4BBz/44fr7vWK7x8rpFtVsSmjLX1upK5jacUhmUUhBmIz51FtunzmDZwh0s+MIImdEi8C60wWzLaUloryT0hNkQ9ZgNUTi2DW0kCRgGOOGIpL7FRvtnNL2zD97Ys6DjQ4hevfLqlW3uLpcsG5pTKr/FN7V6RGMMdDINx6BwygZsg4IzgvDYKazf0gHf7V+gnNmNZdODqI+GVanI913uL07OOyVjj3IrAUyk4a5ZBYcS2JTCpgyCMgRLM/DVxICui0BvAfhwGpqRhuoo9RoA+M8PnCu1b9mhjqW+shvqY071CoAwSMbBBUVRDQgyetkTuPgeOJ0FAVBaUmGryCtPvrHY9IJuc9EjhdjpCLNNWlZzTSGfvNYZOewJBj6qDVua5sqhNG/h7pxqm0x+8hTwf13vrDtgFPL7VFuJ2qqckUDf60PWkX8BnoTdhvAVaYUAAAAASUVORK5CYII=');
insert into dbo.Image (Id, Content) values (5, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAEUSURBVCjPXdFNSsMAEIbh0Su4teAdIgEvJB5C14K4UexCEFQEKfivtKIIIlYQdKPiDUTRKtb0x6ZJ+volraEJ3+zmycwkMczGzTE3lwkbxeLE5XTqQfTIjhIm6bCy9E/icoOoyR4v7PLDN+8ibxQHxGzE3JBfHrgUalDnQ6BNk1WRFPjs66kDNTxqg0Uh5qYg4IkrjrS9pTWfmvKaBaGaNU4EY+Lpkq88eKZKmTAhbd3i5UFZg0+TzV1d1FZy4FCpJCAQ8DUnA86ZpciiXjbQhK7aObDOGnNsUkra/WRAiQXdvSwWpBkGvQpnbHHMRvqRlCgBqkm/dd2745YbtofafsOcPiiMTc1fzNzHma4O/XLHCtgfTLBbxm6KrMIAAAAASUVORK5CYII=');
insert into dbo.Image (Id, Content) values (6, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAIYSURBVDjLfZK/a1NhFIafm+YmTauoFTEodmgdxK1THfIHOIlQBwcXkYKb4FQcOlSHTo51qOggXcW/QUpLUQoKVWhd7GKEGoxNbu693/nhkLYkJnjgcJbvec/L+53I3Tmum8/e+/1bV9n83sDEUTVUDVNDxKhNn2dlbZuPK3eiY6ZIT5kqZo6EI1C6U6XbIo6K9iL9AifbgnahHvhE8B+BQp8DUdpJ4NLpMiHXvr5ypkIryVD9rwNdOvjyYfHehU0ulvcYtTYAiVf4wRSvd2YwKS71MlFviL5Wm0+0/Dy+fvdUKE2iWsAlJZKEuLNPvvu2NU7yuPjw0+qAgL+5MQvRu3zmSTXLy1jyG0nbeEhxySEaoTwaMbb7ok7w2/Gjna3+DFQW5NqDaiYVNGmieRf0kGNpgjQPSBpN0sm5qh3qwkCIblIL41NY57ALSg4SsJDhkmOhg/z5RUfGINPaYIjmE+YjeEgxyXENmHRhzY9EshTNBNNoYsg3Oq6KSTixftJ6NCXHNcNtyB24eSMKLTDtty5ZN4eQAQaSQaAx6EDDerH5lagYY5r3We9uVgpxhdHsJ5KzPuigY8vF7Vf1OEooxKNghmvAQwB3RirjlMdjip836m6F5aGHlD+9Oo+wlM/MVdPSZVQMzxIICaX2PsXtjbpJtHh2dW91qABAujA9ay1ZIFjNPJpAwT1qmLBupXj53MtvW73v/wKskrUnmSsmJgAAAABJRU5ErkJggg==');
insert into dbo.Image (Id, Content) values (7, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAJqSURBVDjLpZNLSJRRFMd/M9/okF86IONzClciCRNGZS/BFoIa9BBDrSSC0F2rIFxZUAaDrWrXoggEqVBxHRSmofighUk2jEXjPBxHRbQv1O8+Wozo2MrowuFy7uH+z+/+OdehteZ/lgugZ3i1U2vapFaHlFJIBUIppFRIpRFSpYVECo1UaqKrtbTSBaC0vtNYme39l84PXoeO7hBIpbwAg99fIZRASIGtBLa0d3cpdmodZ7qwbelOE0j5cL389r66WxsCW8hdD6RUAPSOLO5L4NKJXLbSBcS2AMC1qnzefErQdK5g56xvLEHj6d18aW1jL4EtFUprXAb0jS5iGE76xxZxOMG5fWlwfBG0JsMFR3xZbNl/PUEDLsNBQ2Ueg+NJLlfm7yFIz0OxNYRQewm0ApcTBkYjRL5NEhiaI9+bS3Qhic9fQ++HX8yN9eMr9LK8vMKBdQ/V1R1mSkAotNY4tWB19h16fZ1bN1uxLItIJMLo+Ec82SbNV69gGAbxeJzMqSlWcnLup0xUKZzQzCTxYIjmG9d48vQ5s9MTFBUW4vf7Cf/8QXf3BPGFBY4dP0VtzXnC4XC7E0AIgQbCoRk8OQcBeNR5D2HbtLS0UFVVRX19PXV1dQjbpqm1HQCPx+Pe9UBryksPM/15MjWqDx8jhCAQCGCaZmqALAulFD0vnnHxQi3RaHTDobXm7suvI8KWFavJeXPty1vOnqyg2OcjK9NJIpEgGAzidrspKSmhoKCA35uKWHTeHh56P+dI/85lZWVGUVGR3zTNgeLi4jy3220AzqWlpTYg6vV6B4CMzc1NGYvFkpZlNfwBMWlOUI5ySkcAAAAASUVORK5CYII=');
insert into dbo.Image (Id, Content) values (8, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAG5SURBVBgZpcG7b41xAMfhz/v2SJ1qI2nVedXtD0ClsdpIdDARBlKRaEIMLP4OCZNYJGIQl0EQiYnJytSRRA8nLnGrSy+/z1dHObH1eapLL86FVUlIQgyX91+v+I+zT2aiQcUSVGpWdQa3sL29kxhMmovPZ0Ofs09momkQOu2GzlAHi9RJSEJnsGFrewct1vU09LOIxd6m9jhbh7cxULVQqWPo/X7Pm4U3DFcb2L1xkij9imFq8z5GWiN0v3d5/fk1pUhtQimlefezy2CrTZUKS+hnkQTWt4bofuuiNhapknDh2ZnEoEElhmvTNyv+cere8ahosIjKnZkHVZWEtahZo5o1qlmjFqtmH52MBouoaLh17G7FP47cOJwYLKJB5fH5p1U9++hkLDYDGWDX2B4mx6ewSD9LmJzYy66J3ahomumrB1NbRNMbWz/Ot99fWV5ZwiL9VBbLEl9+fWHT8DhV6KnUFmmGJhgdHOXH4gKv3r9EpZ9F5ubnWFpeobOxw+jwGDG0ivJn+Q/zi/N8XPhAKTZqjz4aiovN/Ke3PUshBhOqE7ePRsUiGlTun35Y8R+HrhxIDCbEkIS/gKBKja+GF3wAAAAASUVORK5CYII=');
insert into dbo.Image (Id, Content) values (9, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAALASURBVDjLdZPLS1tBFMaDf4D7LLqviy66aulSsnBRaDWLSqFgmvRBUhG7UDQoJBpiSGpKTQrRIIqvYBRMKJHeRuMzPq/GNAbFx8JHLwoKLZau7v16zlDTBuzAMAx3vt/5zjdzdQB0N821tTXz0tJSamFhIUXD/L9zRZutra2yjY2NUhKXkPj89PQUJycnGBsbO08kEiXxeLx0fHy87EYAiXtIrK6urirpdFo/NzenHB4e4uDgACRUYrGYnkDKyMiIOjAw0FMEyGQy9v39fVxcXGBvbw8kvpqentby+TxyuRwmJiY0El+RMyiKgsnJSXi9XnsBQFVbqFeNISzY3d0VoGsA77PZLBiwvLyMpqYmrb6+vqWohcXFRRcfXl9fx8rKCiRJQjgcRn9/PzsCtYXZ2VlR3ePxuAotEFGm6sczMzOXOzs7kGUZyWQSTqcz3djYaGhtbTX4/f70/Py8APF3n8936Xa7j9va2mQdidWzszNhlytTkBgaGkJ7e7vhukp3d7eBMgCdFc7YDYdrs9lUHd2xenR0JHrkD1yBEkdXV1cBEAwGDZFIRDjgFsitOG8ymVQdXYlMFo/7+vouNzc3BYRz6O3tTYdCIUMgEBAthKKdePvxGV52PsJTZ7n2+HX5d6PRKBdCJIsuClIExSs9JIyOjoLuHYGIB46oCZ9yQWS+SfB/seKJ/w7u2fQ+IY5Goy3Dw8Pa9va2EPN10cMSmTCoxlOB2Nf3iOU/gIcv+QL+5CsG/BKAwcFBOyfPL49AoHSvXC6XxqFx3w/td5HIhfHviGeDDPj7ph0OR09dXZ1qsViUhoYGPUEUdsIOHry5pXml53BLNULs/lxT7OB6EqDMarWWNjc3lxDwfGpqiv8DVFju/zT6buOdZBGVeeV9IYObZm1trbm6ujpVWVmZqqqqMtPhDpo/2PaftYPP/QZledsx50IwXwAAAABJRU5ErkJggg==');
insert into dbo.Image (Id, Content) values (10, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAANpSURBVDjLfdPdb1N1AMbx5/ScvtHTZbSwDcrWlXXIUOdkZiRmioQXSYgX82p4YUKMkJjswpkRjCJckUWDhBCZGoJhYrwYMIUQzbhReZOZLtvqateVgdKVjYV2W3t+b+fl5wWSwI3fP+CT5+ZRpJR43LHkYZ1bopsJsZMJ2sYEB+NsmDLxkyo2HamUnd7Pd0cInkh5DBwdP7SZm+KbjZXtMVXzwVRsVPlXYiqXwoWJ7/siypdJYVo9Qth7Tu1t+PUp4LOxgx117viFcGA1ZsRDjJZTUKULL+sv4rvfvy74rY62oLJtuC2uhybuLuHv++U3B/Y3DwKA69PRgyEmWH+VXoeRcga/LdzEgrmIuD+Kudl7MAz6cUBu/WBdlS9UvdyHxlU6KBX9Ow7cCAGAi3Da3Vq5Wc/SHFJkEsRiWKmGoDM3fhg/NxpRT9xi1Nwbrw0gnWcIVXjRuCaoM0K7/wOMXarbi2Q5DWFxVLh0NFesx3DmOmiJdZlcO96yNqgK00HuoUBmlqMmHACjbBcAaISyDVyx4IKCFv051Hsj+Gc6i0Q2cToW7F9NKW+NhP24mSEghg1jyUZTxA3OaAwANIMSWu1b4WkPvoS5/D30jRwtcEMcP1R84+TkYkIbCjyTfVBkz2tQQAwH0nHAhQZBmfpoAaF3/vjrRsulPwfnOeW9+++vGdhaCLwtycTkKyTx2qUNPWDcBiES1LARXu7GzIMyBKfZR4BBz/44fr7vWK7x8rpFtVsSmjLX1upK5jacUhmUUhBmIz51FtunzmDZwh0s+MIImdEi8C60wWzLaUloryT0hNkQ9ZgNUTi2DW0kCRgGOOGIpL7FRvtnNL2zD97Ys6DjQ4hevfLqlW3uLpcsG5pTKr/FN7V6RGMMdDINx6BwygZsg4IzgvDYKazf0gHf7V+gnNmNZdODqI+GVanI913uL07OOyVjj3IrAUyk4a5ZBYcS2JTCpgyCMgRLM/DVxICui0BvAfhwGpqRhuoo9RoA+M8PnCu1b9mhjqW+shvqY071CoAwSMbBBUVRDQgyetkTuPgeOJ0FAVBaUmGryCtPvrHY9IJuc9EjhdjpCLNNWlZzTSGfvNYZOewJBj6qDVua5sqhNG/h7pxqm0x+8hTwf13vrDtgFPL7VFuJ2qqckUDf60PWkX8BnoTdhvAVaYUAAAAASUVORK5CYII=');


GO

SET IDENTITY_INSERT dbo.Video ON

insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (1, '10/25/2022', 'Etiam pretium iaculis justo.', 'Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', 7, 996, 'http://ca.gov', 4);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (2, '12/2/2022', 'Nulla suscipit ligula in lacus.', 'Duis at velit eu est congue elementum.', 6, 902, 'https://omniture.com', 7);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (3, '11/13/2022', 'Pellentesque ultrices mattis odio.', 'Morbi a ipsum.', 4, 547, 'https://networksolutions.com', 3);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (4, '8/13/2023', 'Integer ac neque.', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 11, 158, 'http://huffingtonpost.com', 9);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (5, '5/9/2023', 'Nunc rhoncus dui vel sem.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus.', 9, 715, 'https://comsenz.com', 2);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (6, '7/4/2023', 'Morbi a ipsum.', 'Nullam molestie nibh in lectus.', 10, 886, 'https://usatoday.com', 1);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (7, '5/2/2023', 'Cras pellentesque volutpat dui.', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.', 14, 999, 'http://bloglines.com', 4);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (8, '2/3/2023', 'Integer ac leo.', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', 8, 338, 'http://soundcloud.com', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (9, '7/27/2023', 'Vestibulum rutrum rutrum neque.', 'In congue. Etiam justo.', 4, 17, 'http://nbcnews.com', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (10, '11/2/2022', 'Phasellus in felis.', 'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 9, 975, 'https://wsj.com', 1);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (11, '4/24/2023', 'Pellentesque viverra pede ac diam.', 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 8, 271, 'https://unblog.fr', 3);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (12, '4/13/2023', 'Ut tellus.', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 7, 704, 'http://addthis.com', 1);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (13, '6/13/2023', 'In sagittis dui vel nisl.', 'Fusce posuere felis sed lacus.', 8, 182, 'http://indiatimes.com', 3);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (14, '1/25/2023', 'Integer tincidunt ante vel ipsum.', 'Maecenas pulvinar lobortis est.', 10, 531, 'https://friendfeed.com', 2);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (15, '1/5/2023', 'Nulla tellus.', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', 9, 609, 'https://fema.gov', 2);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (16, '4/1/2023', 'Phasellus in felis.', 'Etiam pretium iaculis justo. In hac habitasse platea dictumst.', 11, 926, 'http://weather.com', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (17, '7/21/2023', 'Ut at dolor quis odio consequat varius.', 'Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo.', 15, 653, 'http://canalblog.com', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (18, '11/6/2022', 'Vestibulum ac est lacinia nisi venenatis tristique.', 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 11, 721, 'https://reference.com', 6);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (19, '9/27/2023', 'Nulla ut erat id mauris vulputate elementum.', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 3, 621, 'https://cnbc.com', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (20, '11/5/2022', 'Phasellus in felis.', 'Nullam molestie nibh in lectus. Pellentesque at nulla.', 12, 27, 'http://pcworld.com', 7);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (21, '1/11/2023', 'Praesent blandit.', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 1, 102, 'https://si.edu', 4);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (22, '11/15/2022', 'Proin interdum mauris non ligula pellentesque ultrices.', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', 10, 142, 'https://gmpg.org', 1);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (23, '8/31/2023', 'Proin eu mi.', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 15, 526, 'https://ezinearticles.com', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (24, '2/19/2023', 'Etiam vel augue.', 'Proin eu mi. Nulla ac enim.', 8, 946, 'http://instagram.com', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (25, '8/19/2023', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 12, 499, 'https://freewebs.com', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (26, '8/9/2023', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 'Praesent blandit.', 11, 672, 'http://ifeng.com', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (27, '8/8/2023', 'Donec vitae nisi.', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 14, 92, 'http://fotki.com', 6);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (28, '6/2/2023', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus.', 2, 469, 'https://hibu.com', 3);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (29, '9/25/2023', 'Fusce posuere felis sed lacus.', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 10, 743, 'http://china.com.cn', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (30, '11/26/2022', 'Donec vitae nisi.', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 12, 53, 'http://wunderground.com', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (31, '5/31/2023', 'Nam tristique tortor eu pede.', 'Morbi non lectus.', 13, 862, 'http://opensource.org', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (32, '7/27/2023', 'Integer a nibh.', 'Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.', 15, 899, 'http://netvibes.com', 2);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (33, '7/5/2023', 'Nulla ac enim.', 'Sed sagittis.', 15, 821, 'http://marketwatch.com', 6);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (34, '4/5/2023', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', 'Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 9, 512, 'http://yolasite.com', 9);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (35, '4/28/2023', 'Donec ut mauris eget massa tempor convallis.', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 10, 839, 'http://weebly.com', 3);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (36, '2/8/2023', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 15, 613, 'http://mac.com', 6);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (37, '12/15/2022', 'Nulla justo.', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 5, 91, 'https://blog.com', 6);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (38, '11/6/2022', 'Mauris sit amet eros.', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', 6, 796, 'http://yelp.com', 6);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (39, '8/12/2023', 'Pellentesque at nulla.', 'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.', 7, 543, 'http://arstechnica.com', 3);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (40, '9/28/2023', 'Etiam justo.', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 7, 98, 'http://tumblr.com', 2);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (41, '6/23/2023', 'Donec semper sapien a libero.', 'Nunc purus. Phasellus in felis.', 8, 789, 'http://biblegateway.com', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (42, '3/7/2023', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.', 'Morbi non quam nec dui luctus rutrum. Nulla tellus.', 6, 965, 'https://msu.edu', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (43, '4/19/2023', 'Suspendisse accumsan tortor quis turpis.', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.', 13, 673, 'http://census.gov', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (44, '4/26/2023', 'Duis mattis egestas metus.', 'Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', 6, 577, 'http://upenn.edu', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (45, '12/11/2022', 'In hac habitasse platea dictumst.', 'In quis justo.', 1, 547, 'http://feedburner.com', 2);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (46, '4/17/2023', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.', 13, 395, 'http://google.de', 9);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (47, '11/29/2022', 'Integer ac neque.', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue.', 9, 965, 'http://mashable.com', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (48, '6/1/2023', 'Nam nulla.', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.', 12, 798, 'http://vk.com', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (49, '9/17/2023', 'Nulla ut erat id mauris vulputate elementum.', 'Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.', 5, 304, 'https://newsvine.com', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (50, '1/23/2023', 'Mauris lacinia sapien quis libero.', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 15, 486, 'https://earthlink.net', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (51, '6/2/2023', 'Duis ac nibh.', 'Cras in purus eu magna vulputate luctus.', 6, 947, 'https://comsenz.com', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (52, '1/10/2023', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 'Morbi non lectus.', 10, 630, 'https://un.org', 7);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (53, '5/5/2023', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'Sed vel enim sit amet nunc viverra dapibus.', 5, 566, 'http://vinaora.com', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (54, '4/24/2023', 'Suspendisse potenti.', 'Nulla nisl.', 1, 304, 'http://sbwire.com', 9);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (55, '8/11/2023', 'Vestibulum sed magna at nunc commodo placerat.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus.', 6, 85, 'https://topsy.com', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (56, '7/13/2023', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 'Praesent id massa id nisl venenatis lacinia.', 13, 114, 'https://tiny.cc', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (57, '9/27/2023', 'Suspendisse potenti.', 'Donec posuere metus vitae ipsum.', 2, 500, 'http://360.cn', 2);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (58, '5/15/2023', 'Donec ut dolor.', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.', 1, 802, 'http://vinaora.com', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (59, '9/19/2023', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.', 'Duis ac nibh.', 11, 495, 'http://mayoclinic.com', 4);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (60, '5/9/2023', 'In hac habitasse platea dictumst.', 'Ut at dolor quis odio consequat varius.', 14, 90, 'https://newsvine.com', 7);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (61, '6/2/2023', 'Nam nulla.', 'Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.', 5, 878, 'https://flickr.com', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (62, '6/28/2023', 'Integer ac leo.', 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', 10, 965, 'https://guardian.co.uk', 3);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (63, '3/12/2023', 'Vivamus tortor.', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 2, 950, 'https://nature.com', 7);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (64, '5/15/2023', 'Sed sagittis.', 'Maecenas pulvinar lobortis est.', 13, 713, 'https://cnet.com', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (65, '1/16/2023', 'Suspendisse potenti.', 'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', 10, 877, 'http://over-blog.com', 7);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (66, '12/8/2022', 'Maecenas rhoncus aliquam lacus.', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.', 15, 173, 'http://washingtonpost.com', 2);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (67, '5/21/2023', 'Vestibulum rutrum rutrum neque.', 'Vestibulum sed magna at nunc commodo placerat.', 1, 609, 'https://mysql.com', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (68, '6/4/2023', 'Nunc purus.', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 15, 507, 'http://washingtonpost.com', 3);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (69, '9/15/2023', 'Duis aliquam convallis nunc.', 'Nunc purus. Phasellus in felis.', 2, 613, 'http://cam.ac.uk', 1);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (70, '5/5/2023', 'In eleifend quam a odio.', 'In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', 7, 621, 'http://usnews.com', 7);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (71, '11/27/2022', 'Suspendisse potenti.', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 8, 90, 'http://sogou.com', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (72, '5/26/2023', 'Nulla suscipit ligula in lacus.', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.', 7, 662, 'https://youku.com', 10);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (73, '11/9/2022', 'Curabitur at ipsum ac tellus semper interdum.', 'Duis mattis egestas metus. Aenean fermentum.', 9, 937, 'https://networkadvertising.org', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (74, '7/31/2023', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 6, 7, 'https://state.gov', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (75, '7/7/2023', 'Vivamus tortor.', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.', 9, 230, 'http://imageshack.us', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (76, '12/19/2022', 'Suspendisse potenti.', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.', 10, 935, 'https://desdev.cn', 9);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (77, '8/25/2023', 'Donec ut dolor.', 'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 12, 48, 'https://unblog.fr', 1);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (78, '8/12/2023', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', 'Nunc purus. Phasellus in felis.', 15, 638, 'https://blogspot.com', 9);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (79, '3/1/2023', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.', 14, 975, 'http://hao123.com', 9);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (80, '7/30/2023', 'Duis aliquam convallis nunc.', 'Ut at dolor quis odio consequat varius. Integer ac leo.', 11, 802, 'http://google.co.uk', 9);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (81, '4/21/2023', 'Nulla suscipit ligula in lacus.', 'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.', 2, 334, 'https://geocities.com', 1);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (82, '5/9/2023', 'In eleifend quam a odio.', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 8, 299, 'https://simplemachines.org', 1);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (83, '5/21/2023', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.', 4, 575, 'https://wp.com', 4);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (84, '11/14/2022', 'Maecenas rhoncus aliquam lacus.', 'Sed vel enim sit amet nunc viverra dapibus.', 6, 421, 'https://nature.com', 1);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (85, '9/24/2023', 'Pellentesque eget nunc.', 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 11, 594, 'http://lycos.com', 3);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (86, '7/28/2023', 'Nunc rhoncus dui vel sem.', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 7, 637, 'https://dmoz.org', 2);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (87, '10/13/2022', 'Cras pellentesque volutpat dui.', 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.', 3, 590, 'http://acquirethisname.com', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (88, '6/6/2023', 'Maecenas rhoncus aliquam lacus.', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum.', 2, 162, 'https://4shared.com', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (89, '1/27/2023', 'Praesent blandit.', 'Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus.', 6, 887, 'http://va.gov', 8);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (90, '5/1/2023', 'Nunc purus.', 'Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', 14, 455, 'http://etsy.com', 7);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (91, '9/5/2023', 'Phasellus in felis.', 'Etiam pretium iaculis justo.', 3, 332, 'http://blogs.com', 6);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (92, '2/12/2023', 'Sed ante.', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 3, 642, 'https://mlb.com', 4);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (93, '1/24/2023', 'Etiam vel augue.', 'Donec semper sapien a libero. Nam dui.', 12, 491, 'http://psu.edu', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (94, '7/23/2023', 'Aenean lectus.', 'Pellentesque viverra pede ac diam.', 8, 190, 'http://mapy.cz', 3);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (95, '3/31/2023', 'Curabitur at ipsum ac tellus semper interdum.', 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', 6, 255, 'http://goo.gl', 9);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (96, '6/28/2023', 'In eleifend quam a odio.', 'Cras pellentesque volutpat dui.', 10, 762, 'https://intel.com', 5);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (97, '7/8/2023', 'Duis consequat dui nec nisi volutpat eleifend.', 'Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 4, 295, 'https://gnu.org', 9);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (98, '2/6/2023', 'Donec ut dolor.', 'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 14, 264, 'http://eepurl.com', 7);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (99, '2/11/2023', 'Curabitur gravida nisi at nibh.', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 2, 988, 'http://homestead.com', 2);
insert into dbo.Video (Id, CreatedAt, Name, Description, GenreId, TotalSeconds, StreamingUrl, ImageId) values (100, '2/3/2023', 'In hac habitasse platea dictumst.', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio.', 1, 471, 'http://woothemes.com', 7);
SET IDENTITY_INSERT dbo.Video OFF
GO

SET IDENTITY_INSERT dbo.VideoTag ON

insert into dbo.VideoTag (Id, VideoId, TagId) values (1, 63, 30);
insert into dbo.VideoTag (Id, VideoId, TagId) values (2, 33, 24);
insert into dbo.VideoTag (Id, VideoId, TagId) values (3, 88, 13);
insert into dbo.VideoTag (Id, VideoId, TagId) values (4, 33, 7);
insert into dbo.VideoTag (Id, VideoId, TagId) values (5, 62, 21);
insert into dbo.VideoTag (Id, VideoId, TagId) values (6, 28, 17);
insert into dbo.VideoTag (Id, VideoId, TagId) values (7, 30, 25);
insert into dbo.VideoTag (Id, VideoId, TagId) values (8, 78, 4);
insert into dbo.VideoTag (Id, VideoId, TagId) values (9, 18, 9);
insert into dbo.VideoTag (Id, VideoId, TagId) values (10, 31, 12);
insert into dbo.VideoTag (Id, VideoId, TagId) values (11, 26, 6);
insert into dbo.VideoTag (Id, VideoId, TagId) values (12, 56, 3);
insert into dbo.VideoTag (Id, VideoId, TagId) values (13, 100, 12);
insert into dbo.VideoTag (Id, VideoId, TagId) values (14, 98, 1);
insert into dbo.VideoTag (Id, VideoId, TagId) values (15, 70, 12);
insert into dbo.VideoTag (Id, VideoId, TagId) values (16, 55, 23);
insert into dbo.VideoTag (Id, VideoId, TagId) values (17, 58, 25);
insert into dbo.VideoTag (Id, VideoId, TagId) values (18, 78, 13);
insert into dbo.VideoTag (Id, VideoId, TagId) values (19, 69, 7);
insert into dbo.VideoTag (Id, VideoId, TagId) values (20, 58, 21);
insert into dbo.VideoTag (Id, VideoId, TagId) values (21, 72, 10);
insert into dbo.VideoTag (Id, VideoId, TagId) values (22, 78, 19);
insert into dbo.VideoTag (Id, VideoId, TagId) values (23, 75, 9);
insert into dbo.VideoTag (Id, VideoId, TagId) values (24, 5, 30);
insert into dbo.VideoTag (Id, VideoId, TagId) values (25, 94, 12);
insert into dbo.VideoTag (Id, VideoId, TagId) values (26, 44, 29);
insert into dbo.VideoTag (Id, VideoId, TagId) values (27, 55, 29);
insert into dbo.VideoTag (Id, VideoId, TagId) values (28, 58, 24);
insert into dbo.VideoTag (Id, VideoId, TagId) values (29, 98, 3);
insert into dbo.VideoTag (Id, VideoId, TagId) values (30, 94, 25);
insert into dbo.VideoTag (Id, VideoId, TagId) values (31, 72, 29);
insert into dbo.VideoTag (Id, VideoId, TagId) values (32, 18, 1);
insert into dbo.VideoTag (Id, VideoId, TagId) values (33, 79, 27);
insert into dbo.VideoTag (Id, VideoId, TagId) values (34, 72, 3);
insert into dbo.VideoTag (Id, VideoId, TagId) values (35, 31, 16);
insert into dbo.VideoTag (Id, VideoId, TagId) values (36, 66, 2);
insert into dbo.VideoTag (Id, VideoId, TagId) values (37, 74, 26);
insert into dbo.VideoTag (Id, VideoId, TagId) values (38, 4, 22);
insert into dbo.VideoTag (Id, VideoId, TagId) values (39, 14, 11);
insert into dbo.VideoTag (Id, VideoId, TagId) values (40, 97, 21);
insert into dbo.VideoTag (Id, VideoId, TagId) values (41, 8, 3);
insert into dbo.VideoTag (Id, VideoId, TagId) values (42, 4, 8);
insert into dbo.VideoTag (Id, VideoId, TagId) values (43, 6, 6);
insert into dbo.VideoTag (Id, VideoId, TagId) values (44, 6, 14);
insert into dbo.VideoTag (Id, VideoId, TagId) values (45, 20, 14);
insert into dbo.VideoTag (Id, VideoId, TagId) values (46, 7, 11);
insert into dbo.VideoTag (Id, VideoId, TagId) values (47, 8, 10);
insert into dbo.VideoTag (Id, VideoId, TagId) values (48, 36, 11);
insert into dbo.VideoTag (Id, VideoId, TagId) values (49, 63, 30);
insert into dbo.VideoTag (Id, VideoId, TagId) values (50, 20, 26);
insert into dbo.VideoTag (Id, VideoId, TagId) values (51, 64, 9);
insert into dbo.VideoTag (Id, VideoId, TagId) values (52, 61, 4);
insert into dbo.VideoTag (Id, VideoId, TagId) values (53, 39, 27);
insert into dbo.VideoTag (Id, VideoId, TagId) values (54, 60, 14);
insert into dbo.VideoTag (Id, VideoId, TagId) values (55, 38, 9);
insert into dbo.VideoTag (Id, VideoId, TagId) values (56, 90, 17);
insert into dbo.VideoTag (Id, VideoId, TagId) values (57, 3, 23);
insert into dbo.VideoTag (Id, VideoId, TagId) values (58, 20, 19);
insert into dbo.VideoTag (Id, VideoId, TagId) values (59, 12, 20);
insert into dbo.VideoTag (Id, VideoId, TagId) values (60, 72, 2);
insert into dbo.VideoTag (Id, VideoId, TagId) values (61, 47, 28);
insert into dbo.VideoTag (Id, VideoId, TagId) values (62, 96, 2);
insert into dbo.VideoTag (Id, VideoId, TagId) values (63, 74, 8);
insert into dbo.VideoTag (Id, VideoId, TagId) values (64, 34, 29);
insert into dbo.VideoTag (Id, VideoId, TagId) values (65, 50, 11);
insert into dbo.VideoTag (Id, VideoId, TagId) values (66, 52, 4);
insert into dbo.VideoTag (Id, VideoId, TagId) values (67, 81, 11);
insert into dbo.VideoTag (Id, VideoId, TagId) values (68, 10, 23);
insert into dbo.VideoTag (Id, VideoId, TagId) values (69, 7, 13);
insert into dbo.VideoTag (Id, VideoId, TagId) values (70, 13, 4);
insert into dbo.VideoTag (Id, VideoId, TagId) values (71, 55, 12);
insert into dbo.VideoTag (Id, VideoId, TagId) values (72, 40, 12);
insert into dbo.VideoTag (Id, VideoId, TagId) values (73, 14, 4);
insert into dbo.VideoTag (Id, VideoId, TagId) values (74, 61, 20);
insert into dbo.VideoTag (Id, VideoId, TagId) values (75, 96, 30);
insert into dbo.VideoTag (Id, VideoId, TagId) values (76, 5, 18);
insert into dbo.VideoTag (Id, VideoId, TagId) values (77, 17, 8);
insert into dbo.VideoTag (Id, VideoId, TagId) values (78, 35, 14);
insert into dbo.VideoTag (Id, VideoId, TagId) values (79, 52, 10);
insert into dbo.VideoTag (Id, VideoId, TagId) values (80, 27, 15);
insert into dbo.VideoTag (Id, VideoId, TagId) values (81, 78, 27);
insert into dbo.VideoTag (Id, VideoId, TagId) values (82, 62, 24);
insert into dbo.VideoTag (Id, VideoId, TagId) values (83, 94, 16);
insert into dbo.VideoTag (Id, VideoId, TagId) values (84, 21, 12);
insert into dbo.VideoTag (Id, VideoId, TagId) values (85, 65, 24);
insert into dbo.VideoTag (Id, VideoId, TagId) values (86, 61, 20);
insert into dbo.VideoTag (Id, VideoId, TagId) values (87, 67, 5);
insert into dbo.VideoTag (Id, VideoId, TagId) values (88, 60, 7);
insert into dbo.VideoTag (Id, VideoId, TagId) values (89, 92, 20);
insert into dbo.VideoTag (Id, VideoId, TagId) values (90, 45, 25);
insert into dbo.VideoTag (Id, VideoId, TagId) values (91, 42, 22);
insert into dbo.VideoTag (Id, VideoId, TagId) values (92, 12, 9);
insert into dbo.VideoTag (Id, VideoId, TagId) values (93, 37, 26);
insert into dbo.VideoTag (Id, VideoId, TagId) values (94, 73, 29);
insert into dbo.VideoTag (Id, VideoId, TagId) values (95, 1, 1);
insert into dbo.VideoTag (Id, VideoId, TagId) values (96, 83, 2);
insert into dbo.VideoTag (Id, VideoId, TagId) values (97, 6, 14);
insert into dbo.VideoTag (Id, VideoId, TagId) values (98, 23, 3);
insert into dbo.VideoTag (Id, VideoId, TagId) values (99, 60, 16);
insert into dbo.VideoTag (Id, VideoId, TagId) values (100, 39, 3);

SET IDENTITY_INSERT dbo.VideoTag OFF

GO

select * from Country
select * from Genre
select * from Image
select * from Notification
select * from Tag
select * from [User]
select * from Video
select * from VideoTag
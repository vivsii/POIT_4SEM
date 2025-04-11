use CosmeticsShop;
INSERT [dbo].[PRODUCTS] ([ProductID], [Name], [Description], [Price], [Category]) VALUES (153, N'CELIMAX dual barrier creamy toner', N'Увлажняющий тонер с молочной текстурой Dual Barrier Creamy Toner направленно работает на восстановление защитного барьера эпидермиса и его функций',
CAST(340.40 AS Decimal(8, 2)), N'Для лица')
INSERT [dbo].[PRODUCTS] ([ProductID], [Name], [Description], [Price], [Category]) VALUES (76,N'CELIMAX the real noni energy ampoule mist', N'Мист – палочка-выручалочка для быстрого, но эффективного увлажнения',
CAST(230.00 AS Decimal(8, 2)), N'Для лица')
INSERT [dbo].[PRODUCTS] ([ProductID], [Name], [Description], [Price], [Category]) VALUES (54,N'CELIMAX the real noni ultimate eye cream', N'Интенсивно омолаживающий крем содержит в себе большое количество высокоактивного антиоксидантного экстракта Нони',
CAST(230.00 AS Decimal(8, 2)), N'Для лица')
INSERT [dbo].[PRODUCTS] ([ProductID], [Name], [Description], [Price], [Category]) VALUES (201,N'PUSY hyaluronic body cream',  N'Нежный крем с легкой воздушной текстурой смягчает кожу, увлажняет, убирает ощущение стянутости.',
CAST(230.00 AS Decimal(8, 2)), N'Для тела')
INSERT [dbo].[PRODUCTS] ([ProductID], [Name], [Description], [Price], [Category]) VALUES (103,N'PAYOT gel de douche intégral visage et corps', N'Мягкое универсальное средство разработано для очищения лица и тела, а также волос.',
CAST(230.00 AS Decimal(8, 2)), N'Для тела')
INSERT [dbo].[PRODUCTS] ([ProductID], [Name], [Description], [Price], [Category]) VALUES (250, N'LA SULTANE DE SABA rose', N'Питательные масла карите и сладкого миндаля, входящие в состав бальзама, способствуют увлажнению и восстановлению кожи. ',
CAST(2220.00 AS Decimal(8, 2)), N'Для тела')
INSERT [dbo].[PRODUCTS] ([ProductID], [Name], [Description], [Price], [Category]) VALUES (59, N'LADOR hydro lpp treatment',  N'Профессиональная маска поможет значительно улучшить состояние поврежденных волос, оздоравливая от корней до самых кончиков.',
CAST(240.00 AS Decimal(8, 2)), N'Для волос')
INSERT [dbo].[PRODUCTS] ([ProductID], [Name], [Description], [Price], [Category]) VALUES (2,N'K18 peptide prep detox shampoo',  N'Шампуни для создания абсолютно чистой и здоровой основы перед последующим восстановлением с уходом К18 и салонными процедурами',
CAST(540.00 AS Decimal(8, 2)), N'Для волос')
INSERT [dbo].[PRODUCTS] ([ProductID], [Name], [Description], [Price], [Category]) VALUES (73,N'LIMBA COSMETICS keracomplex',N'Активаторы Limba Cosmetics — это концентраты премиального сырья с высокой степенью эффективности.',
CAST(690.00 AS Decimal(8, 2)), N'Для волос')
INSERT [dbo].[CLIENT] ([ClientID], [Name],[LastName], [Address], [Email], [Phone]) VALUES (25,N'Виктория', N'Евсеенко', N'Ул. Лученка 32', N'vikaevseenko2805@mail.ru',  6152805)
INSERT [dbo].[CLIENT] ([ClientID], [Name],[LastName], [Address], [Email], [Phone]) VALUES (75,N'Александра', N'Север',  N'Ул. Свердлова 26',N'alexandra22@mail.ru',  99532475)
INSERT [dbo].[CLIENT] ([ClientID], [Name],[LastName], [Address], [Email], [Phone]) VALUES (562,N'Мария', N'Сосновец', N'Пр. Мира 7',  N'mashka@gmail.com', 6552279)
INSERT [dbo].[CLIENT] ([ClientID], [Name],[LastName], [Address], [Email], [Phone]) VALUES (1560,N'Дарья', N'Сосновец', N'Пр. Мира 7',  N'dashka@mail.ru', 7774654)
INSERT [dbo].[CLIENT] ([ClientID], [Name],[LastName], [Address], [Email], [Phone]) VALUES (1821,N'Валерия', N'Яскевич', N'Ул. Белорусская 19', N'lerka@mail.ru',  664225)
INSERT [dbo].[CLIENT] ([ClientID], [Name],[LastName], [Address], [Email], [Phone]) VALUES (2410,N'Виолетта', N'Бабич', N'Ул. Бобруйская 25', N'vltt@gmail.com',  6152134)
INSERT [dbo].[CLIENT] ([ClientID], [Name],[LastName], [Address], [Email], [Phone]) VALUES (41,N'Людмила', N'Евсеенко', N'Ул. Лученка 32',  N'levseenko@mail.ru', 6968239)
INSERT [dbo].[CLIENT] ([ClientID], [Name],[LastName], [Address], [Email], [Phone]) VALUES (1737,N'София', N'Евсеенко', N'Ул. Лученка 32',N'sofiya2009@mail.ru',  6112909)
INSERT [dbo].[ORDERS] ([OrderID], [Client_ID], [ProductID],[DateOrder], [Statuss]) VALUES (170,25,103, '2024-04-22',N'Отправлен')
INSERT [dbo].[ORDERS] ([OrderID], [Client_ID],[ProductID], [DateOrder], [Statuss]) VALUES (763,1737,59, '2024-03-12',N'Доставлен')
INSERT [dbo].[ORDERS] ([OrderID], [Client_ID], [ProductID],[DateOrder], [Statuss]) VALUES (36,2410,250,'2024-04-02',N'Доставлен')
INSERT [dbo].[ORDERS] ([OrderID], [Client_ID], [ProductID],[DateOrder], [Statuss]) VALUES (12,1560,73,'2024-04-21',N'Доставлен')
INSERT [dbo].[ORDERS] ([OrderID], [Client_ID], [ProductID],[DateOrder], [Statuss]) VALUES (5152, 1821,54,'2024-04-14',N'Отправлен')
INSERT [dbo].[ORDERS] ([OrderID], [Client_ID], [ProductID],[DateOrder], [Statuss]) VALUES (788,75,76,'2024-04-19',N'Отправлен')
INSERT [dbo].[ORDERS] ([OrderID], [Client_ID], [ProductID],[DateOrder], [Statuss]) VALUES (1353,562,76,'2024-04-22',N'Оформлен')
INSERT [dbo].[ORDERS] ([OrderID], [Client_ID], [ProductID],[DateOrder], [Statuss]) VALUES (11,41,2,'2024-04-22',N'Оформлен')


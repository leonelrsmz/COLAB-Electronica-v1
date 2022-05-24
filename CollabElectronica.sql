Create database CollabElectronica;
Use CollabElectronica;


/*///////////////Sin FK/////////////////*/
Create table `Client`(
 `client_id`  int unsigned NOT NULL ,
`colabCredits` int unsigned NOT NULL,
`rateStatus` varchar(20) NOT NULL,
`ocupation` varchar(200),
`rol` varchar(60) NOT NULL,
`profilePicture` blob,
`telephone` varchar(40) NOT NULL,
`user_id` int unsigned NOT NULL,
`noTier` int unsigned NOT NULL,
`forumPoints` int unsigned NOT NULL,
primary key (`client_id`));

Create table `User`(
`User_id` int unsigned not null,
`firstName` varchar (100) Not null,
`lastName` varchar (100) not null,
`password` varchar(200) not null,
`email` varchar (250) not null,
`createDate` timestamp not null,
primary key(`User_id`));



create table `address`(
`address_id` int unsigned not null,
`country`varchar(100),
`city` varchar(100),
`postalCode`tinyint not null,
`billingAddress_line1` varchar(400) not null,
`billingAddress_line2` varchar(400),
`details` varchar(400),
primary key(`address_id`));

create table `category`(
`category_id`int unsigned not null,
`categoryName`varchar(200)not null,
`clasification`varchar(200)not null,
`electronicClass`varchar(200)not null,
`difficultyLevel`varchar(200),
primary key(`category_id`));

create table `component`(
`component_id`int unsigned not null,
`name` varchar(200) not null,
`category` varchar (80) not null,
`componentPic` blob,
`description` varchar(300),
primary key(`component_id`));


create table `materialResources`(
`resources_id` int unsigned not null,
`code` longblob,
`diagram_desc` varchar (400) not null,
`diagram_archive` longblob,
`datasheet_desc`varchar(400) not null,
`datasheet_archive` longblob,
`picture` longblob,
primary key(`resources_id`));



create table `proyectStats`(
`proyectStats_id`int unsigned not null,
`views` mediumint,
`likes` mediumint,
`coments` int,
`shares` int,
`public_status`varchar (40) not null,
primary key(`proyectStats_id`));

create table `discount`(
`discount_id` int unsigned not null,
`name` varchar(80),
`description` varchar (200),
`disc_percent`decimal not null,
`status` boolean not null,
`createdAt` timestamp not null,
primary key(`discount_id`));

create table `shopSection`(
`shopSection_id` int unsigned not null,
`name` varchar(80) not null,
`description` varchar (200) not null,
primary key(`shopSection_id`));

create table `tag`(
`tag_id`int unsigned not null,
`name` varchar (80) not null,
`metaTitle` varchar(100) not null,
`slug` varchar(100) not null,
primary key(`tag_id`));
/*///////////////Con FK/////////////////*/
create table `invoice`(
`invoice_id` int unsigned not null,
`client_id` int unsigned not null,
primary key(`invoice_id`),
constraint `InvoiceClient` foreign key (`client_id`) 
references `client` (`client_id`));

create table `proyect`(
`proyect_id` int unsigned not null,
`title` varchar(200) not null,
`createDate` timestamp not null,
`modifiedAt`datetime,
`coverImage` blob,
`proyectMotif` varchar(80) not null,
`description` varchar(400),
`stepList`varchar(400) not null,
`resources_id` int unsigned not null,
`proyectStats_id` int unsigned not null,
primary key(`proyect_id`),
constraint `ResourcesProyect` foreign key (`resources_id`) 
references `materialResources` (`resources_id`),
constraint `proyectStatsProyect` foreign key (`proyectStats_id`) 
references `proyectstats` (`proyectStats_id`));

create table `collaborator`(
`collaborators_id` int not null,
`proyect_id` int unsigned not null,
`client_id` int unsigned not null,
primary key (`collaborators_id`),
constraint `ProyectCollaborators` foreign key (`proyect_id`) 
references `proyect` (`proyect_id`),
constraint `ClientCollaborators` foreign key (`client_id`) 
references `Client` (`client_id`));

create table `ComponentList`(
`componentList_id`int unsigned not null,
`component_id`int unsigned not null,
`proyect_id` int unsigned not null,
`amount`int unsigned,
primary key(`componentList_id`),
constraint `CompListComp` foreign key (`component_id`) 
references `component` (`component_id`),
constraint `ProyectCompList` foreign key (`proyect_id`) 
references `proyect` (`proyect_id`));

create table `product`(
`product_id` int unsigned not null,
`sku` varchar(200) not null,
`verifiedDate` datetime not null,
`price` decimal not null,
`coverImage` blob,
`weight` varchar(80) not null,
`descSale` varchar (100),
`rate` float not null,
`proyect_id` int unsigned not null,
`componentList_id`int unsigned not null,
`discount_id` int unsigned not null,
`shopSection_id` int unsigned not null,
primary key (`product_id`),
constraint `ProyectProduct` foreign key (`proyect_id`) 
references `proyect` (`proyect_id`),
constraint `ProductCompList` foreign key (`componentList_id`) 
references `ComponentList` (`componentList_id`),
constraint `ProductDiscount` foreign key (`discount_id`) 
references `discount` (`discount_id`),
constraint `ProductShopSec` foreign key (`shopSection_id`) 
references `shopSection` (`shopSection_id`));

create table `productReview`(
`productReview_id` int unsigned not null,
`title` varchar (100) not null,
`rating` float not null,
`content` varchar(400),
`createdDate` datetime not null,
`product_id` int unsigned not null,
primary key (`productReview_id`),
constraint `ProductRevProd` foreign key (`product_id`) 
references `product` (`product_id`));

create table `productTag`(
`productTag_id` int unsigned not null,
`tag_id` int unsigned not null,
`product_id` int unsigned not null,
primary key (`productTag_id`),
constraint `TagProdTag` foreign key (`tag_id`) 
references `tag` (`tag_id`),
constraint `ProdTagProd` foreign key (`product_id`) 
references `product` (`product_id`));


create table `moderator`(
`moderator_id`int unsigned not null,
`createDate` timestamp not null,
`rareStatus` float not null,
`level` varchar(40)not null,
`upgradePosts` int unsigned,
`description` varchar(200),
`client_id` int unsigned  not null,
primary key(`moderator_id`),
constraint `ClientMod` foreign key (`client_id`) 
references `Client` (`client_id`));

create table `paycard`(
`paycard_id` int unsigned not null,
`name_holder`varchar (100) not null,
`pan` mediumint not null,
`expiration` varchar(100) not null,
`ccv` tinyint,
`brand` varchar (50) not null,
`client_id` int unsigned not null,
primary key (`paycard_id`),
constraint `PayCardClient` foreign key (`client_id`) 
references `Client` (`client_id`));

create table `forumCRUD`(
`forumCRUD_id` int unsigned not null,
`movement` varchar (40) not null,
`description` varchar(200),
`createDate` timestamp not null,
`proyect_id` int unsigned not null,
`moderator_id` int unsigned not null, 
primary key (`forumCRUD_id`),
constraint `ProyectForumCRUD` foreign key (`proyect_id`) 
references `proyect` (`proyect_id`),
constraint `ModeratorForumCRUD` foreign key (`moderator_id`) 
references `moderator` (`moderator_id`));

create table `clientAddress`(
`clientaddress_id` int unsigned not null,
`client_id` int unsigned not null,
`address_id` int unsigned not null,
primary key(`clientaddress_id`),
constraint `ClientAddressCli` foreign key (`client_id`) 
references `Client` (`client_id`),
constraint `AddressClientAddress` foreign key (`address_id`) 
references `address` (`address_id`));

create table `paymentDetails`(
`paymentDetails_id` int unsigned not null,
`status` varchar (100) not null,
`totalPay` decimal not null,
`provider` varchar (100) not null,
`modified_at` timestamp not null,
`description` varchar (400) not null,
`paycard_id`int unsigned not null,
primary key (`paymentDetails_id`),
constraint `PayCardDetails` foreign key (`paycard_id`) 
references `paycard` (`paycard_id`));

create table `orderDetails`(
`orderDetails_id`int unsigned not null,
`total` decimal not null,
`orderStatus` varchar (50) not null,
`modified_at`timestamp not null,
`billTo_name` varchar(100) not null,
`dropshipping_stats` varchar (40) not null,
`client_id` int unsigned not null,
`paymentDetails_id` int unsigned not null,
primary key(`orderDetails_id`),
constraint `ClientOrderDetails` foreign key (`client_id`) 
references `Client` (`client_id`),
constraint `PayDetOrdDet` foreign key (`paymentDetails_id`) 
references `paymentDetails` (`paymentDetails_id`));

create table `invoiceDetails`(
`invoiceDetails_id` int unsigned not null,
`CFDI` varchar (200) not null,
`taxData` varchar (200) not null,
`modified_at` timestamp not null,
`created_at` timestamp not null,
`description` varchar (400) not null,
`price` varchar (400)not null,
`invoice_id` int unsigned not null,
`product_id` int unsigned not null,
primary key (`invoiceDetails_id`),
constraint `InvDetInv` foreign key (`invoice_id`) 
references `invoice` (`invoice_id`),
constraint `ProdInvDet` foreign key (`product_id`) 
references `product` (`product_id`));

create table `administrator`(
`admin_id` int unsigned not null,
`password` varchar (200) not null,
`lastConnection` datetime,
`profilePicture`blob,
`createDate` timestamp,
`user_id`int unsigned not null,
primary key (`admin_id`),
constraint `UserAdmin` foreign key (`user_id`) 
references `User` (`User_id`));

create table `proyectCategory`(
`proyectCategory_id` int unsigned not null,
`proyect_id`int unsigned not null,
`category_id` int unsigned not null,
primary key (`proyectCategory_id`),
constraint `ProCatPro` foreign key (`proyect_id`) 
references `proyect` (`proyect_id`),
constraint `CatProCat` foreign key (`category_id`) 
references `category` (`category_id`));

create table `cart`(
`cartItem_id`int unsigned not null,
`quantity` int not null,
`modified_at` timestamp not null,
`total`decimal not null,
`product_id` int unsigned not null,
primary key(`cartItem_id`),
constraint `ProdCart` foreign key (`product_id`) 
references `product` (`product_id`));

create table `orderItem`(
`orderItems_id` int unsigned not null,
`quantity` int not null,
`modified_at` timestamp not null,
`product_id`int unsigned not null,
`orderDetails_id` int unsigned not null,
primary key (`orderItems_id`),
constraint `OrdItmProd` foreign key (`product_id`) 
references `product` (`product_id`),
constraint `OrdDetOrdItm` foreign key (`orderDetails_id`) 
references `orderDetails` (`orderDetails_id`));
/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2013/10/22 9:56:04                           */
/*==============================================================*/


drop table if exists tb_contract_doc;

drop table if exists tb_contract_doc_type;

drop table if exists tb_contract_doc_variable;

drop table if exists tb_contract_templates;

drop table if exists tb_contract_templates_doc;

drop table if exists tb_contract_templates_doc_variable;

drop table if exists tb_contract_templates_relationship;

drop table if exists tb_data_record;

drop table if exists tb_data_source;

drop table if exists tb_data_source_type;

drop table if exists tb_product_category;

drop table if exists tb_product_type;

/*==============================================================*/
/* Table: tb_contract_doc                                       */
/*==============================================================*/
create table tb_contract_doc
(
   doc_id               varchar(32) not null,
   templatesDoc_id      varchar(32),
   createtime           date comment '����ʱ��',
   exportPath           varchar(100),
   fileName             varchar(100),
   primary key (doc_id)
);

alter table tb_contract_doc comment '��ͬ�ļ�';

/*==============================================================*/
/* Table: tb_contract_doc_type                                  */
/*==============================================================*/
create table tb_contract_doc_type
(
   docType_id           varchar(32) not null,
   typename             varchar(30) comment '��������',
   primary key (docType_id)
);

alter table tb_contract_doc_type comment '��ͬ�ļ�����';

/*==============================================================*/
/* Table: tb_contract_doc_variable                              */
/*==============================================================*/
create table tb_contract_doc_variable
(
   docVariable          varchar(32) not null,
   doc_id               varchar(32),
   variableName         varchar(50) comment '��������',
   content              varchar(100) comment '����',
   primary key (docVariable)
);

alter table tb_contract_doc_variable comment '��ͬ�ļ�����';

/*==============================================================*/
/* Table: tb_contract_templates                                 */
/*==============================================================*/
create table tb_contract_templates
(
   templates_id         varchar(32) not null,
   createtime           date comment '����ʱ��',
   status               int comment '״̬',
   templatesName        varchar(50),
   primary key (templates_id)
);

alter table tb_contract_templates comment '��ͬģ��';

/*==============================================================*/
/* Table: tb_contract_templates_doc                             */
/*==============================================================*/
create table tb_contract_templates_doc
(
   templatesDoc_id      varchar(32) not null,
   docType_id           varchar(32),
   docName              varchar(50) comment '�ļ�����',
   path                 varchar(1024) comment '·��',
   createtime           date comment '����ʱ��',
   bVariable            int comment '�Ƿ����ñ���(0���ޱ�����1���б���)',
   primary key (templatesDoc_id)
);

alter table tb_contract_templates_doc comment '��ͬģ���ļ�';

/*==============================================================*/
/* Table: tb_contract_templates_doc_variable                    */
/*==============================================================*/
create table tb_contract_templates_doc_variable
(
   templates_doc_variable_id varchar(32) not null,
   templatesDoc_id      varchar(32),
   variableName         varchar(50) comment '��������',
   description          varchar(100) comment '����',
   primary key (templates_doc_variable_id)
);

alter table tb_contract_templates_doc_variable comment '��ͬģ���ļ���������';

/*==============================================================*/
/* Table: tb_contract_templates_relationship                    */
/*==============================================================*/
create table tb_contract_templates_relationship
(
   templates_doc_id     varchar(32) not null,
   templatesDoc_id      varchar(32),
   templates_id         varchar(32),
   primary key (templates_doc_id)
);

alter table tb_contract_templates_relationship comment '��ͬģ����ģ���ļ���ϵ��';

/*==============================================================*/
/* Table: tb_data_record                                        */
/*==============================================================*/
create table tb_data_record
(
   record_id            varchar(32) not null comment 'ID',
   source_id            varchar(32) comment 'ID',
   productType_id       varchar(32) comment 'ID',
   productorderno       varchar(50) comment '��Ʒ������',
   productDesc          varchar(100) comment '��Ʒ����',
   quantity             int comment '����',
   unitPrice            varchar(50) comment 'Ŀ¼����',
   discountRate         varchar(50) comment '�ۿ���',
   otherRates           varchar(50) comment '�˱�����������',
   installServiceCharge varchar(50) comment '��װ�����',
   firstYear            varchar(50) comment '��һ�걣�޸�',
   secondYear           varchar(50) comment '�ڶ��걣�޷�',
   thirdYear            varchar(50) comment '�����걣�޷�',
   remark               varchar(100) comment '��ע',
   primary key (record_id)
);

alter table tb_data_record comment '����Դ���ݼ�¼';

/*==============================================================*/
/* Table: tb_data_source                                        */
/*==============================================================*/
create table tb_data_source
(
   source_id            varchar(32) not null comment 'ID',
   type_id              varchar(32) comment 'ID',
   status               int comment '״̬',
   description          varchar(100) comment '����',
   createtime           date comment '����ʱ��',
   sourceName           varchar(50),
   primary key (source_id)
);

alter table tb_data_source comment '����Դ�ܱ�';

/*==============================================================*/
/* Table: tb_data_source_type                                   */
/*==============================================================*/
create table tb_data_source_type
(
   type_id              varchar(32) not null comment 'ID',
   sourceTypeName       varchar(50),
   primary key (type_id)
);

alter table tb_data_source_type comment '����Դ����';

/*==============================================================*/
/* Table: tb_product_category                                   */
/*==============================================================*/
create table tb_product_category
(
   category_id          varchar(32) not null comment 'ID',
   isRepeat             int comment '����Ƿ��������(0���߿գ�����������1������������)',
   productCategoryName  varchar(50),
   primary key (category_id)
);

alter table tb_product_category comment '��Ʒ����';

/*==============================================================*/
/* Table: tb_product_type                                       */
/*==============================================================*/
create table tb_product_type
(
   productType_id       varchar(32) not null comment 'ID',
   category_id          varchar(32) comment 'ID',
   productTypeName      varchar(50),
   primary key (productType_id)
);

alter table tb_product_type comment '��Ʒ����';

alter table tb_contract_doc add constraint FK_Relationship_12 foreign key (templatesDoc_id)
      references tb_contract_templates_doc (templatesDoc_id) on delete restrict on update restrict;

alter table tb_contract_doc_variable add constraint FK_Relationship_6 foreign key (doc_id)
      references tb_contract_doc (doc_id) on delete restrict on update restrict;

alter table tb_contract_templates_doc add constraint FK_Relationship_13 foreign key (docType_id)
      references tb_contract_doc_type (docType_id) on delete restrict on update restrict;

alter table tb_contract_templates_doc_variable add constraint FK_Relationship_11 foreign key (templatesDoc_id)
      references tb_contract_templates_doc (templatesDoc_id) on delete restrict on update restrict;

alter table tb_contract_templates_relationship add constraint FK_Relationship_10 foreign key (templatesDoc_id)
      references tb_contract_templates_doc (templatesDoc_id) on delete restrict on update restrict;

alter table tb_contract_templates_relationship add constraint FK_Relationship_9 foreign key (templates_id)
      references tb_contract_templates (templates_id) on delete restrict on update restrict;

alter table tb_data_record add constraint FK_Relationship_15 foreign key (productType_id)
      references tb_product_type (productType_id) on delete restrict on update restrict;

alter table tb_data_record add constraint FK_Relationship_2 foreign key (source_id)
      references tb_data_source (source_id) on delete restrict on update restrict;

alter table tb_data_source add constraint FK_Relationship_1 foreign key (type_id)
      references tb_data_source_type (type_id) on delete restrict on update restrict;

alter table tb_product_type add constraint FK_Relationship_3 foreign key (category_id)
      references tb_product_category (category_id) on delete restrict on update restrict;


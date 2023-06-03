.class public Lcom/adobe/air/RscIdMap;
.super Ljava/lang/Object;
.source "RscIdMap.java"


# static fields
.field private static s_resourceMap:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;>;"
        }
    .end annotation
.end field


# instance fields
.field private m_resourceIds:Ljava/util/Hashtable;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2
    .param p1, "resourceClass"    # Ljava/lang/String;

    .prologue
    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    sget-object v0, Lcom/adobe/air/RscIdMap;->s_resourceMap:Ljava/util/Hashtable;

    if-nez v0, :cond_0

    .line 14
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    sput-object v0, Lcom/adobe/air/RscIdMap;->s_resourceMap:Ljava/util/Hashtable;

    .line 16
    :cond_0
    sget-object v0, Lcom/adobe/air/RscIdMap;->s_resourceMap:Ljava/util/Hashtable;

    invoke-virtual {v0, p1}, Ljava/util/Hashtable;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 18
    new-instance v0, Ljava/util/Hashtable;

    invoke-direct {v0}, Ljava/util/Hashtable;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/RscIdMap;->m_resourceIds:Ljava/util/Hashtable;

    .line 19
    iget-object v0, p0, Lcom/adobe/air/RscIdMap;->m_resourceIds:Ljava/util/Hashtable;

    invoke-static {p1, v0}, Lcom/adobe/air/RscIdMap;->gatherResourceInfo(Ljava/lang/String;Ljava/util/Hashtable;)V

    .line 20
    sget-object v0, Lcom/adobe/air/RscIdMap;->s_resourceMap:Ljava/util/Hashtable;

    iget-object v1, p0, Lcom/adobe/air/RscIdMap;->m_resourceIds:Ljava/util/Hashtable;

    invoke-virtual {v0, p1, v1}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 26
    :goto_0
    return-void

    .line 24
    :cond_1
    sget-object v0, Lcom/adobe/air/RscIdMap;->s_resourceMap:Ljava/util/Hashtable;

    invoke-virtual {v0, p1}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Hashtable;

    iput-object v0, p0, Lcom/adobe/air/RscIdMap;->m_resourceIds:Ljava/util/Hashtable;

    goto :goto_0
.end method

.method private static gatherResourceInfo(Ljava/lang/String;Ljava/util/Hashtable;)V
    .locals 18
    .param p0, "resourceClass"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Hashtable",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 34
    .local p1, "resourceIds":Ljava/util/Hashtable;, "Ljava/util/Hashtable<Ljava/lang/String;Ljava/lang/Integer;>;"
    :try_start_0
    invoke-static/range {p0 .. p0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 35
    .local v1, "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-virtual {v1}, Ljava/lang/Class;->getClasses()[Ljava/lang/Class;

    move-result-object v4

    .line 36
    .local v4, "clss":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    array-length v12, v4

    const/4 v10, 0x0

    move v11, v10

    :goto_0
    if-ge v11, v12, :cond_2

    aget-object v2, v4, v11

    .line 38
    .local v2, "cls":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    .line 39
    .local v3, "clsName":Ljava/lang/String;
    const/16 v10, 0x24

    invoke-virtual {v3, v10}, Ljava/lang/String;->lastIndexOf(I)I

    move-result v10

    add-int/lit8 v8, v10, 0x1

    .line 40
    .local v8, "indexOfDollarSign":I
    if-lez v8, :cond_0

    .line 42
    invoke-virtual {v3, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v3

    .line 44
    :cond_0
    invoke-virtual {v2}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v7

    .line 45
    .local v7, "fields":[Ljava/lang/reflect/Field;
    array-length v13, v7

    const/4 v10, 0x0

    :goto_1
    if-ge v10, v13, :cond_3

    aget-object v6, v7, v10
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_1

    .line 49
    .local v6, "f":Ljava/lang/reflect/Field;
    :try_start_1
    const-string v14, "%s.%s"

    const/4 v15, 0x2

    new-array v15, v15, [Ljava/lang/Object;

    const/16 v16, 0x0

    aput-object v3, v15, v16

    const/16 v16, 0x1

    invoke-virtual {v6}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v17

    aput-object v17, v15, v16

    invoke-static {v14, v15}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v9

    .line 50
    .local v9, "rscKey":Ljava/lang/String;
    move-object/from16 v0, p1

    invoke-virtual {v0, v9}, Ljava/util/Hashtable;->containsKey(Ljava/lang/Object;)Z

    move-result v14

    if-eqz v14, :cond_1

    .line 52
    sget-object v14, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v15, "Did not add duplicate resource key %s"

    const/16 v16, 0x1

    move/from16 v0, v16

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v16, v0

    const/16 v17, 0x0

    aput-object v9, v16, v17

    invoke-virtual/range {v14 .. v16}, Ljava/io/PrintStream;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;

    .line 45
    .end local v9    # "rscKey":Ljava/lang/String;
    :goto_2
    add-int/lit8 v10, v10, 0x1

    goto :goto_1

    .line 57
    .restart local v9    # "rscKey":Ljava/lang/String;
    :cond_1
    invoke-virtual {v6, v2}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I

    move-result v14

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    move-object/from16 v0, p1

    invoke-virtual {v0, v9, v14}, Ljava/util/Hashtable;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/ClassNotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    .line 60
    .end local v9    # "rscKey":Ljava/lang/String;
    :catch_0
    move-exception v5

    .line 62
    .local v5, "e":Ljava/lang/IllegalArgumentException;
    :try_start_2
    sget-object v14, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v15, "IllegalArgumentException"

    const/16 v16, 0x0

    move/from16 v0, v16

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v16, v0

    invoke-virtual/range {v14 .. v16}, Ljava/io/PrintStream;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
    :try_end_2
    .catch Ljava/lang/ClassNotFoundException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_2

    .line 71
    .end local v1    # "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v2    # "cls":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v3    # "clsName":Ljava/lang/String;
    .end local v4    # "clss":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    .end local v5    # "e":Ljava/lang/IllegalArgumentException;
    .end local v6    # "f":Ljava/lang/reflect/Field;
    .end local v7    # "fields":[Ljava/lang/reflect/Field;
    .end local v8    # "indexOfDollarSign":I
    :catch_1
    move-exception v5

    .line 72
    .local v5, "e":Ljava/lang/ClassNotFoundException;
    sget-object v10, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v11, "Class not found:  %s%n%n"

    const/4 v12, 0x1

    new-array v12, v12, [Ljava/lang/Object;

    const/4 v13, 0x0

    aput-object p0, v12, v13

    invoke-virtual {v10, v11, v12}, Ljava/io/PrintStream;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;

    .line 74
    .end local v5    # "e":Ljava/lang/ClassNotFoundException;
    :cond_2
    return-void

    .line 64
    .restart local v1    # "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .restart local v2    # "cls":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .restart local v3    # "clsName":Ljava/lang/String;
    .restart local v4    # "clss":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    .restart local v6    # "f":Ljava/lang/reflect/Field;
    .restart local v7    # "fields":[Ljava/lang/reflect/Field;
    .restart local v8    # "indexOfDollarSign":I
    :catch_2
    move-exception v5

    .line 66
    .local v5, "e":Ljava/lang/IllegalAccessException;
    :try_start_3
    sget-object v14, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v15, "IllegalAccessException"

    const/16 v16, 0x0

    move/from16 v0, v16

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v16, v0

    invoke-virtual/range {v14 .. v16}, Ljava/io/PrintStream;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
    :try_end_3
    .catch Ljava/lang/ClassNotFoundException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_2

    .line 36
    .end local v5    # "e":Ljava/lang/IllegalAccessException;
    .end local v6    # "f":Ljava/lang/reflect/Field;
    :cond_3
    add-int/lit8 v10, v11, 0x1

    move v11, v10

    goto/16 :goto_0
.end method


# virtual methods
.method public getId(Ljava/lang/String;)I
    .locals 2
    .param p1, "resourceString"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;,
            Landroid/content/res/Resources$NotFoundException;
        }
    .end annotation

    .prologue
    .line 78
    if-nez p1, :cond_0

    .line 80
    new-instance v1, Ljava/lang/IllegalArgumentException;

    invoke-direct {v1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw v1

    .line 82
    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v0

    .line 83
    .local v0, "internedResourceString":Ljava/lang/String;
    iget-object v1, p0, Lcom/adobe/air/RscIdMap;->m_resourceIds:Ljava/util/Hashtable;

    invoke-virtual {v1, v0}, Ljava/util/Hashtable;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 85
    new-instance v1, Landroid/content/res/Resources$NotFoundException;

    invoke-direct {v1, v0}, Landroid/content/res/Resources$NotFoundException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 87
    :cond_1
    iget-object v1, p0, Lcom/adobe/air/RscIdMap;->m_resourceIds:Ljava/util/Hashtable;

    invoke-virtual {v1, v0}, Ljava/util/Hashtable;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    return v1
.end method

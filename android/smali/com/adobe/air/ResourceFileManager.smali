.class public final Lcom/adobe/air/ResourceFileManager;
.super Ljava/lang/Object;
.source "ResourceFileManager.java"


# instance fields
.field private final mAppContext:Landroid/content/Context;

.field private final mAppResources:Landroid/content/res/Resources;

.field private mResourceIdMap:Lcom/adobe/air/ResourceIdMap;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 4
    .param p1, "appContext"    # Landroid/content/Context;

    .prologue
    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    const/4 v2, 0x0

    iput-object v2, p0, Lcom/adobe/air/ResourceFileManager;->mResourceIdMap:Lcom/adobe/air/ResourceIdMap;

    .line 45
    iput-object p1, p0, Lcom/adobe/air/ResourceFileManager;->mAppContext:Landroid/content/Context;

    .line 46
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    iput-object v2, p0, Lcom/adobe/air/ResourceFileManager;->mAppResources:Landroid/content/res/Resources;

    .line 50
    :try_start_0
    iget-object v2, p0, Lcom/adobe/air/ResourceFileManager;->mAppContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    .line 51
    .local v0, "cl":Ljava/lang/ClassLoader;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/adobe/air/ResourceFileManager;->mAppContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ".R"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 52
    .local v1, "resourceClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v2, Lcom/adobe/air/ResourceIdMap;

    invoke-direct {v2, v1}, Lcom/adobe/air/ResourceIdMap;-><init>(Ljava/lang/Class;)V

    iput-object v2, p0, Lcom/adobe/air/ResourceFileManager;->mResourceIdMap:Lcom/adobe/air/ResourceIdMap;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 58
    .end local v0    # "cl":Ljava/lang/ClassLoader;
    .end local v1    # "resourceClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_0
    return-void

    .line 54
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method private remapSpecialFileNames(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "resName"    # Ljava/lang/String;

    .prologue
    .line 131
    const-string v0, "ss.cfg"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "ss.sgn"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "mms.cfg"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 133
    :cond_0
    const/16 v0, 0x2e

    const/16 v1, 0x5f

    invoke-virtual {p1, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    .line 135
    :goto_0
    return-object v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private resExists(Ljava/lang/String;)Z
    .locals 4
    .param p1, "resName"    # Ljava/lang/String;

    .prologue
    .line 143
    const/4 v1, 0x0

    .line 145
    .local v1, "retVal":Z
    invoke-direct {p0, p1}, Lcom/adobe/air/ResourceFileManager;->remapSpecialFileNames(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 146
    .local v0, "remappedResName":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 148
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "raw."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/adobe/air/ResourceFileManager;->lookupResId(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {p0, v2}, Lcom/adobe/air/ResourceFileManager;->resExists(I)Z

    move-result v1

    .line 153
    :cond_0
    return v1
.end method


# virtual methods
.method public GetAssetFileDescriptor(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;
    .locals 6
    .param p1, "resName"    # Ljava/lang/String;

    .prologue
    .line 163
    const/4 v0, 0x0

    .line 169
    .local v0, "resFileDes":Landroid/content/res/AssetFileDescriptor;
    :try_start_0
    invoke-direct {p0, p1}, Lcom/adobe/air/ResourceFileManager;->remapSpecialFileNames(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 170
    .local v1, "resIdString":Ljava/lang/String;
    if-eqz v1, :cond_0

    move-object v2, v1

    .line 172
    .local v2, "suffix":Ljava/lang/String;
    :goto_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "android.resource://"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/adobe/air/ResourceFileManager;->mAppContext:Landroid/content/Context;

    invoke-virtual {v5}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/raw/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    .line 174
    .local v3, "uri":Landroid/net/Uri;
    iget-object v4, p0, Lcom/adobe/air/ResourceFileManager;->mAppContext:Landroid/content/Context;

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "r"

    invoke-virtual {v4, v3, v5}, Landroid/content/ContentResolver;->openAssetFileDescriptor(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 181
    .end local v1    # "resIdString":Ljava/lang/String;
    .end local v2    # "suffix":Ljava/lang/String;
    .end local v3    # "uri":Landroid/net/Uri;
    :goto_1
    return-object v0

    .restart local v1    # "resIdString":Ljava/lang/String;
    :cond_0
    move-object v2, p1

    .line 170
    goto :goto_0

    .line 176
    .end local v1    # "resIdString":Ljava/lang/String;
    :catch_0
    move-exception v4

    goto :goto_1
.end method

.method public extractResource(ILjava/io/File;)V
    .locals 1
    .param p1, "resId"    # I
    .param p2, "path"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 100
    invoke-virtual {p0, p1}, Lcom/adobe/air/ResourceFileManager;->getStream(I)Ljava/io/InputStream;

    move-result-object v0

    .line 102
    .local v0, "in":Ljava/io/InputStream;
    invoke-static {v0, p2}, Lcom/adobe/air/utils/Utils;->writeOut(Ljava/io/InputStream;Ljava/io/File;)V

    .line 103
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 104
    return-void
.end method

.method public getFileStreamFromRawRes(I)Ljava/io/InputStream;
    .locals 2
    .param p1, "resId"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/content/res/Resources$NotFoundException;
        }
    .end annotation

    .prologue
    .line 63
    iget-object v1, p0, Lcom/adobe/air/ResourceFileManager;->mAppResources:Landroid/content/res/Resources;

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v0

    .line 65
    .local v0, "stream":Ljava/io/InputStream;
    if-nez v0, :cond_0

    .line 70
    :cond_0
    return-object v0
.end method

.method public getResourceEntryName(I)Ljava/lang/String;
    .locals 2
    .param p1, "id"    # I

    .prologue
    .line 196
    :try_start_0
    iget-object v1, p0, Lcom/adobe/air/ResourceFileManager;->mAppResources:Landroid/content/res/Resources;

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->getResourceEntryName(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 198
    :goto_0
    return-object v1

    .line 197
    :catch_0
    move-exception v0

    .line 198
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "null"

    goto :goto_0
.end method

.method public getResourceName(I)Ljava/lang/String;
    .locals 2
    .param p1, "id"    # I

    .prologue
    .line 187
    :try_start_0
    iget-object v1, p0, Lcom/adobe/air/ResourceFileManager;->mAppResources:Landroid/content/res/Resources;

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 189
    :goto_0
    return-object v1

    .line 188
    :catch_0
    move-exception v0

    .line 189
    .local v0, "e":Ljava/lang/Exception;
    const-string v1, "null"

    goto :goto_0
.end method

.method public getStream(I)Ljava/io/InputStream;
    .locals 2
    .param p1, "resId"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/content/res/Resources$NotFoundException;
        }
    .end annotation

    .prologue
    .line 94
    iget-object v1, p0, Lcom/adobe/air/ResourceFileManager;->mAppResources:Landroid/content/res/Resources;

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object v0

    .line 95
    .local v0, "in":Ljava/io/InputStream;
    return-object v0
.end method

.method public lookupResId(Ljava/lang/String;)I
    .locals 1
    .param p1, "resIdString"    # Ljava/lang/String;

    .prologue
    .line 121
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/ResourceFileManager;->mResourceIdMap:Lcom/adobe/air/ResourceIdMap;

    if-eqz v0, :cond_0

    .line 122
    iget-object v0, p0, Lcom/adobe/air/ResourceFileManager;->mResourceIdMap:Lcom/adobe/air/ResourceIdMap;

    invoke-virtual {v0, p1}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/content/res/Resources$NotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 126
    :goto_0
    return v0

    .line 124
    :catch_0
    move-exception v0

    .line 126
    :cond_0
    const/4 v0, -0x1

    goto :goto_0
.end method

.method public readFileFromRawRes(I)Ljava/lang/String;
    .locals 6
    .param p1, "resId"    # I

    .prologue
    .line 76
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2}, Ljava/lang/String;-><init>()V

    .line 79
    .local v2, "retString":Ljava/lang/String;
    :try_start_0
    invoke-virtual {p0, p1}, Lcom/adobe/air/ResourceFileManager;->getFileStreamFromRawRes(I)Ljava/io/InputStream;

    move-result-object v0

    .line 80
    .local v0, "in":Ljava/io/InputStream;
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 81
    .local v1, "out":Ljava/io/ByteArrayOutputStream;
    invoke-static {v0, v1}, Lcom/adobe/air/utils/Utils;->writeThrough(Ljava/io/InputStream;Ljava/io/OutputStream;)V

    .line 82
    new-instance v3, Ljava/lang/String;

    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    const-string v5, "UTF-8"

    invoke-direct {v3, v4, v5}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "retString":Ljava/lang/String;
    .local v3, "retString":Ljava/lang/String;
    move-object v2, v3

    .line 89
    .end local v0    # "in":Ljava/io/InputStream;
    .end local v1    # "out":Ljava/io/ByteArrayOutputStream;
    .end local v3    # "retString":Ljava/lang/String;
    .restart local v2    # "retString":Ljava/lang/String;
    :goto_0
    return-object v2

    .line 84
    :catch_0
    move-exception v4

    goto :goto_0
.end method

.method public resExists(I)Z
    .locals 4
    .param p1, "resId"    # I

    .prologue
    const/4 v2, 0x0

    .line 110
    if-gtz p1, :cond_1

    .line 114
    :cond_0
    :goto_0
    return v2

    .line 111
    :cond_1
    :try_start_0
    iget-object v3, p0, Lcom/adobe/air/ResourceFileManager;->mAppResources:Landroid/content/res/Resources;

    invoke-virtual {v3, p1}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 112
    .local v1, "in":Ljava/io/InputStream;
    if-eqz v1, :cond_0

    const/4 v2, 0x1

    goto :goto_0

    .line 113
    .end local v1    # "in":Ljava/io/InputStream;
    :catch_0
    move-exception v0

    .line 114
    .local v0, "ex":Ljava/lang/Exception;
    goto :goto_0
.end method

.class public final Lcom/adobe/air/ApplicationFileManager;
.super Ljava/lang/Object;
.source "ApplicationFileManager.java"


# static fields
.field private static final APP_PREFIX:Ljava/lang/String; = "app"

.field private static final APP_XML_PATH:Ljava/lang/String; = "META-INF/AIR/application.xml"

.field private static final ASSET_STRING:Ljava/lang/String; = "assets"

.field public static sAndroidPackageName:Ljava/lang/String;

.field public static sApkPath:Ljava/lang/String;

.field public static sAppDataPath:Ljava/lang/String;

.field public static sInitialContentName:Ljava/lang/String;


# instance fields
.field private final BUFFER_SIZE:I

.field private final DEFAULT_SIZE:I

.field private mFileInfoMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 1

    .prologue
    .line 146
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 61
    const/16 v0, 0x2000

    iput v0, p0, Lcom/adobe/air/ApplicationFileManager;->BUFFER_SIZE:I

    .line 62
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/ApplicationFileManager;->DEFAULT_SIZE:I

    .line 80
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/ApplicationFileManager;->mFileInfoMap:Ljava/util/HashMap;

    .line 147
    invoke-direct {p0}, Lcom/adobe/air/ApplicationFileManager;->getApkPathFile()Ljava/io/File;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/adobe/air/ApplicationFileManager;->procZipContents(Ljava/io/File;)V

    .line 148
    return-void
.end method

.method private static RefreshAppCache(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p0, "appcachepath"    # Ljava/lang/String;
    .param p1, "id"    # Ljava/lang/String;

    .prologue
    .line 448
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 449
    .local v0, "cachedir":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 455
    :goto_0
    return-void

    .line 454
    :cond_0
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v1}, Lcom/adobe/air/ApplicationFileManager;->deleteDir(Ljava/io/File;)Z

    goto :goto_0
.end method

.method public static checkAndCreateAppDataDir()V
    .locals 2

    .prologue
    .line 533
    new-instance v0, Ljava/io/File;

    sget-object v1, Lcom/adobe/air/ApplicationFileManager;->sAppDataPath:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 534
    .local v0, "applicationDir":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-nez v1, :cond_0

    .line 537
    :try_start_0
    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 542
    :cond_0
    :goto_0
    return-void

    .line 538
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private closeInputStream(Ljava/io/InputStream;)V
    .locals 0
    .param p1, "in"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 522
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V

    .line 523
    return-void
.end method

.method private closeOutputStream(Ljava/io/OutputStream;)V
    .locals 0
    .param p1, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 527
    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V

    .line 528
    invoke-virtual {p1}, Ljava/io/OutputStream;->close()V

    .line 529
    return-void
.end method

.method public static deleteDir(Ljava/io/File;)Z
    .locals 6
    .param p0, "file"    # Ljava/io/File;

    .prologue
    const/4 v2, 0x0

    .line 461
    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 463
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 464
    .local v1, "children":[Ljava/io/File;
    array-length v4, v1

    move v3, v2

    :goto_0
    if-ge v3, v4, :cond_2

    aget-object v0, v1, v3

    .line 466
    .local v0, "child":Ljava/io/File;
    invoke-static {v0}, Lcom/adobe/air/ApplicationFileManager;->deleteDir(Ljava/io/File;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 472
    .end local v0    # "child":Ljava/io/File;
    .end local v1    # "children":[Ljava/io/File;
    :cond_0
    :goto_1
    return v2

    .line 464
    .restart local v0    # "child":Ljava/io/File;
    .restart local v1    # "children":[Ljava/io/File;
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 470
    .end local v0    # "child":Ljava/io/File;
    .end local v1    # "children":[Ljava/io/File;
    :cond_2
    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 472
    const/4 v2, 0x1

    goto :goto_1
.end method

.method public static deleteUnzippedContents(Ljava/lang/String;)Z
    .locals 4
    .param p0, "filePath"    # Ljava/lang/String;

    .prologue
    .line 153
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 154
    .local v1, "fileObj":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 156
    invoke-virtual {v1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    .line 158
    .local v0, "aFiles":[Ljava/io/File;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_0

    .line 160
    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/adobe/air/ApplicationFileManager;->deleteUnzippedContents(Ljava/lang/String;)Z

    .line 158
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 163
    .end local v0    # "aFiles":[Ljava/io/File;
    .end local v2    # "i":I
    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    move-result v3

    return v3
.end method

.method public static getAndroidApkPath()Ljava/lang/String;
    .locals 1

    .prologue
    .line 100
    sget-object v0, Lcom/adobe/air/ApplicationFileManager;->sApkPath:Ljava/lang/String;

    return-object v0
.end method

.method public static getAndroidAppDataPath()Ljava/lang/String;
    .locals 1

    .prologue
    .line 106
    sget-object v0, Lcom/adobe/air/ApplicationFileManager;->sAppDataPath:Ljava/lang/String;

    return-object v0
.end method

.method public static getAndroidUnzipContentPath()Ljava/lang/String;
    .locals 1

    .prologue
    .line 122
    sget-object v0, Lcom/adobe/air/ApplicationFileManager;->sAppDataPath:Ljava/lang/String;

    return-object v0
.end method

.method private getApkPathFile()Ljava/io/File;
    .locals 2

    .prologue
    .line 128
    invoke-static {}, Lcom/adobe/air/ApplicationFileManager;->getAndroidApkPath()Ljava/lang/String;

    move-result-object v0

    .line 129
    .local v0, "apkPath":Ljava/lang/String;
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 130
    .local v1, "apkPathFile":Ljava/io/File;
    return-object v1
.end method

.method public static getAppRoot()Ljava/lang/String;
    .locals 2

    .prologue
    .line 117
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/adobe/air/ApplicationFileManager;->getAndroidUnzipContentPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-char v1, Ljava/io/File;->separatorChar:C

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "assets"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getAppXMLRoot()Ljava/lang/String;
    .locals 2

    .prologue
    .line 112
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/adobe/air/ApplicationFileManager;->getAndroidUnzipContentPath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-char v1, Ljava/io/File;->separatorChar:C

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "META-INF/AIR/application.xml"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static processAndroidDataPath(Ljava/lang/String;)V
    .locals 10
    .param p0, "cacheDirPath"    # Ljava/lang/String;

    .prologue
    .line 478
    const-string v6, "app"

    .line 479
    .local v6, "uniqueVersionID":Ljava/lang/String;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    sget-object v8, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "app"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 480
    .local v2, "appCacheDir":Ljava/lang/String;
    const/4 v5, 0x0

    .line 483
    .local v5, "initialContentName":Ljava/lang/String;
    :try_start_0
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v7

    invoke-virtual {v7}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v7

    invoke-virtual {v7}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v7

    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v8

    invoke-virtual {v8}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v8

    invoke-virtual {v8}, Landroid/app/Activity;->getComponentName()Landroid/content/ComponentName;

    move-result-object v8

    const/16 v9, 0x80

    invoke-virtual {v7, v8, v9}, Landroid/content/pm/PackageManager;->getActivityInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ActivityInfo;

    move-result-object v1

    .line 484
    .local v1, "actInfo":Landroid/content/pm/ActivityInfo;
    iget-object v4, v1, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    .line 487
    .local v4, "bundle":Landroid/os/Bundle;
    if-eqz v4, :cond_1

    .line 489
    const-string v7, "uniqueappversionid"

    invoke-virtual {v4, v7}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    move-object v0, v7

    check-cast v0, Ljava/lang/String;

    move-object v6, v0

    .line 493
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->IsGamePreviewMode()Z

    move-result v7

    if-eqz v7, :cond_0

    .line 495
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v7

    invoke-virtual {v7}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v6

    .line 497
    :cond_0
    invoke-static {v2, v6}, Lcom/adobe/air/ApplicationFileManager;->RefreshAppCache(Ljava/lang/String;Ljava/lang/String;)V

    .line 498
    const-string v7, "initialcontent"

    invoke-virtual {v4, v7}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    move-object v0, v7

    check-cast v0, Ljava/lang/String;

    move-object v5, v0
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/NullPointerException; {:try_start_0 .. :try_end_0} :catch_0

    .line 511
    .end local v1    # "actInfo":Landroid/content/pm/ActivityInfo;
    .end local v4    # "bundle":Landroid/os/Bundle;
    :cond_1
    :goto_0
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    sget-object v8, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/adobe/air/ApplicationFileManager;->setAndroidDataPath(Ljava/lang/String;)V

    .line 514
    new-instance v3, Ljava/io/File;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    sget-object v8, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v3, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 515
    .local v3, "appPath":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    .line 517
    invoke-static {v5}, Lcom/adobe/air/ApplicationFileManager;->setInitialContentName(Ljava/lang/String;)V

    .line 518
    return-void

    .line 506
    .end local v3    # "appPath":Ljava/io/File;
    :catch_0
    move-exception v7

    goto :goto_0

    .line 502
    :catch_1
    move-exception v7

    goto :goto_0
.end method

.method public static setAndroidAPKPath(Ljava/lang/String;)V
    .locals 0
    .param p0, "apkPath"    # Ljava/lang/String;

    .prologue
    .line 89
    sput-object p0, Lcom/adobe/air/ApplicationFileManager;->sApkPath:Ljava/lang/String;

    .line 90
    return-void
.end method

.method private static setAndroidDataPath(Ljava/lang/String;)V
    .locals 0
    .param p0, "dataPath"    # Ljava/lang/String;

    .prologue
    .line 94
    sput-object p0, Lcom/adobe/air/ApplicationFileManager;->sAppDataPath:Ljava/lang/String;

    .line 95
    return-void
.end method

.method public static setAndroidPackageName(Ljava/lang/String;)V
    .locals 0
    .param p0, "packageName"    # Ljava/lang/String;

    .prologue
    .line 84
    sput-object p0, Lcom/adobe/air/ApplicationFileManager;->sAndroidPackageName:Ljava/lang/String;

    .line 85
    return-void
.end method

.method private static setInitialContentName(Ljava/lang/String;)V
    .locals 0
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 135
    sput-object p0, Lcom/adobe/air/ApplicationFileManager;->sInitialContentName:Ljava/lang/String;

    .line 136
    return-void
.end method


# virtual methods
.method public addToCache(Ljava/lang/String;)Z
    .locals 2
    .param p1, "filepath"    # Ljava/lang/String;

    .prologue
    .line 248
    sget-object v0, Lcom/adobe/air/ApplicationFileManager;->sInitialContentName:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 250
    sget-object v0, Lcom/adobe/air/ApplicationFileManager;->sInitialContentName:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 251
    const/4 v0, 0x1

    .line 254
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public appDirectoryNameList(Ljava/lang/String;)[Ljava/lang/String;
    .locals 8
    .param p1, "assetPath"    # Ljava/lang/String;

    .prologue
    .line 379
    const-string v5, ""

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "assets"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 382
    .local v0, "assetName":Ljava/lang/String;
    :goto_0
    iget-object v5, p0, Lcom/adobe/air/ApplicationFileManager;->mFileInfoMap:Ljava/util/HashMap;

    invoke-virtual {v5}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 383
    .local v2, "iter":Ljava/util/Iterator;
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 384
    .local v4, "nameList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_0
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 386
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 389
    .local v3, "key":Ljava/lang/String;
    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 393
    invoke-virtual {v3, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 396
    const/4 v5, -0x1

    sget-object v6, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v7

    add-int/lit8 v7, v7, 0x1

    invoke-virtual {v3, v6, v7}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v6

    if-ne v5, v6, :cond_0

    .line 399
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    add-int/lit8 v5, v5, 0x1

    invoke-virtual {v3, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    .line 400
    .local v1, "filename":Ljava/lang/String;
    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 379
    .end local v0    # "assetName":Ljava/lang/String;
    .end local v1    # "filename":Ljava/lang/String;
    .end local v2    # "iter":Ljava/util/Iterator;
    .end local v3    # "key":Ljava/lang/String;
    .end local v4    # "nameList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_1
    const-string v0, "assets"

    goto :goto_0

    .line 403
    .restart local v0    # "assetName":Ljava/lang/String;
    .restart local v2    # "iter":Ljava/util/Iterator;
    .restart local v4    # "nameList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_2
    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [Ljava/lang/String;

    return-object v5
.end method

.method public appDirectoryTypeList(Ljava/lang/String;)[Z
    .locals 11
    .param p1, "assetPath"    # Ljava/lang/String;

    .prologue
    .line 410
    const-string v8, ""

    invoke-virtual {p1, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_1

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "assets"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    sget-object v9, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 413
    .local v0, "assetName":Ljava/lang/String;
    :goto_0
    iget-object v8, p0, Lcom/adobe/air/ApplicationFileManager;->mFileInfoMap:Ljava/util/HashMap;

    invoke-virtual {v8}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    .line 414
    .local v4, "iter":Ljava/util/Iterator;
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    .line 415
    .local v7, "typeList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Boolean;>;"
    :cond_0
    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_2

    .line 417
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    .line 420
    .local v5, "key":Ljava/lang/String;
    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_0

    .line 424
    invoke-virtual {v5, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_0

    .line 427
    const/4 v8, -0x1

    sget-object v9, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v10

    add-int/lit8 v10, v10, 0x1

    invoke-virtual {v5, v9, v10}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v9

    if-ne v8, v9, :cond_0

    .line 430
    iget-object v8, p0, Lcom/adobe/air/ApplicationFileManager;->mFileInfoMap:Ljava/util/HashMap;

    invoke-virtual {v8, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/adobe/air/FileInfo;

    .line 431
    .local v1, "fileInfo":Lcom/adobe/air/FileInfo;
    new-instance v3, Ljava/lang/Boolean;

    iget-boolean v8, v1, Lcom/adobe/air/FileInfo;->mIsFile:Z

    invoke-direct {v3, v8}, Ljava/lang/Boolean;-><init>(Z)V

    .line 432
    .local v3, "isFile":Ljava/lang/Boolean;
    invoke-virtual {v7, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 410
    .end local v0    # "assetName":Ljava/lang/String;
    .end local v1    # "fileInfo":Lcom/adobe/air/FileInfo;
    .end local v3    # "isFile":Ljava/lang/Boolean;
    .end local v4    # "iter":Ljava/util/Iterator;
    .end local v5    # "key":Ljava/lang/String;
    .end local v7    # "typeList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Boolean;>;"
    :cond_1
    const-string v0, "assets"

    goto :goto_0

    .line 437
    .restart local v0    # "assetName":Ljava/lang/String;
    .restart local v4    # "iter":Ljava/util/Iterator;
    .restart local v7    # "typeList":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/Boolean;>;"
    :cond_2
    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v8

    new-array v6, v8, [Z

    .line 439
    .local v6, "list":[Z
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_2
    array-length v8, v6

    if-ge v2, v8, :cond_3

    .line 440
    invoke-virtual {v7, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/Boolean;

    invoke-virtual {v8}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v8

    aput-boolean v8, v6, v2

    .line 439
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 441
    :cond_3
    const/4 v7, 0x0

    .line 442
    return-object v6
.end method

.method public copyFolder(Ljava/lang/String;)V
    .locals 16
    .param p1, "assetPath"    # Ljava/lang/String;

    .prologue
    .line 334
    const-string v13, ""

    move-object/from16 v0, p1

    invoke-virtual {v0, v13}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_1

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "assets"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    sget-object v14, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    move-object/from16 v0, p1

    invoke-virtual {v13, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 335
    .local v6, "fPath":Ljava/lang/String;
    :goto_0
    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/adobe/air/ApplicationFileManager;->getAndroidUnzipContentPath()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    sget-char v14, Ljava/io/File;->separatorChar:C

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 336
    .local v7, "fullDirPath":Ljava/lang/String;
    invoke-direct/range {p0 .. p0}, Lcom/adobe/air/ApplicationFileManager;->getApkPathFile()Ljava/io/File;

    move-result-object v2

    .line 337
    .local v2, "apkPath":Ljava/io/File;
    const/4 v9, 0x0

    .line 342
    .local v9, "out":Ljava/io/BufferedOutputStream;
    :try_start_0
    new-instance v8, Ljava/util/zip/ZipInputStream;

    new-instance v13, Ljava/io/BufferedInputStream;

    new-instance v14, Ljava/io/FileInputStream;

    invoke-direct {v14, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    const/16 v15, 0x2000

    invoke-direct {v13, v14, v15}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;I)V

    invoke-direct {v8, v13}, Ljava/util/zip/ZipInputStream;-><init>(Ljava/io/InputStream;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .local v8, "in":Ljava/util/zip/ZipInputStream;
    move-object v10, v9

    .line 345
    .end local v9    # "out":Ljava/io/BufferedOutputStream;
    .local v10, "out":Ljava/io/BufferedOutputStream;
    :cond_0
    :goto_1
    :try_start_1
    invoke-virtual {v8}, Ljava/util/zip/ZipInputStream;->getNextEntry()Ljava/util/zip/ZipEntry;

    move-result-object v5

    .local v5, "entry":Ljava/util/zip/ZipEntry;
    if-eqz v5, :cond_3

    .line 347
    invoke-virtual {v5}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v3

    .line 350
    .local v3, "assetName":Ljava/lang/String;
    const/4 v13, 0x0

    const-string v14, "assets"

    invoke-virtual {v14}, Ljava/lang/String;->length()I

    move-result v14

    invoke-virtual {v3, v13, v14}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v13

    const-string v14, "assets"

    invoke-virtual {v13, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_0

    .line 353
    invoke-virtual {v3, v6}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v13

    if-eqz v13, :cond_4

    .line 355
    new-instance v1, Ljava/io/File;

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v13, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v1, v13}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 356
    .local v1, "actualFile":Ljava/io/File;
    new-instance v11, Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v11, v13}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 357
    .local v11, "parentFolderHierarchy":Ljava/io/File;
    invoke-virtual {v11}, Ljava/io/File;->mkdirs()Z

    .line 359
    new-instance v9, Ljava/io/BufferedOutputStream;

    new-instance v13, Ljava/io/FileOutputStream;

    invoke-direct {v13, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    const/16 v14, 0x2000

    invoke-direct {v9, v13, v14}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 360
    .end local v10    # "out":Ljava/io/BufferedOutputStream;
    .restart local v9    # "out":Ljava/io/BufferedOutputStream;
    const/16 v13, 0x2000

    :try_start_2
    new-array v4, v13, [B

    .line 361
    .local v4, "data":[B
    const/4 v12, 0x0

    .line 362
    .local v12, "readBytes":I
    :goto_2
    const/4 v13, 0x0

    const/16 v14, 0x2000

    invoke-virtual {v8, v4, v13, v14}, Ljava/util/zip/ZipInputStream;->read([BII)I

    move-result v12

    const/4 v13, -0x1

    if-eq v12, v13, :cond_2

    .line 364
    const/4 v13, 0x0

    invoke-virtual {v9, v4, v13, v12}, Ljava/io/BufferedOutputStream;->write([BII)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_2

    .line 371
    .end local v1    # "actualFile":Ljava/io/File;
    .end local v3    # "assetName":Ljava/lang/String;
    .end local v4    # "data":[B
    .end local v5    # "entry":Ljava/util/zip/ZipEntry;
    .end local v8    # "in":Ljava/util/zip/ZipInputStream;
    .end local v11    # "parentFolderHierarchy":Ljava/io/File;
    .end local v12    # "readBytes":I
    :catch_0
    move-exception v13

    .line 375
    :goto_3
    return-void

    .line 334
    .end local v2    # "apkPath":Ljava/io/File;
    .end local v6    # "fPath":Ljava/lang/String;
    .end local v7    # "fullDirPath":Ljava/lang/String;
    .end local v9    # "out":Ljava/io/BufferedOutputStream;
    :cond_1
    const-string v6, "assets"

    goto/16 :goto_0

    .line 366
    .restart local v1    # "actualFile":Ljava/io/File;
    .restart local v2    # "apkPath":Ljava/io/File;
    .restart local v3    # "assetName":Ljava/lang/String;
    .restart local v4    # "data":[B
    .restart local v5    # "entry":Ljava/util/zip/ZipEntry;
    .restart local v6    # "fPath":Ljava/lang/String;
    .restart local v7    # "fullDirPath":Ljava/lang/String;
    .restart local v8    # "in":Ljava/util/zip/ZipInputStream;
    .restart local v9    # "out":Ljava/io/BufferedOutputStream;
    .restart local v11    # "parentFolderHierarchy":Ljava/io/File;
    .restart local v12    # "readBytes":I
    :cond_2
    :try_start_3
    move-object/from16 v0, p0

    invoke-direct {v0, v9}, Lcom/adobe/air/ApplicationFileManager;->closeOutputStream(Ljava/io/OutputStream;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .end local v1    # "actualFile":Ljava/io/File;
    .end local v4    # "data":[B
    .end local v11    # "parentFolderHierarchy":Ljava/io/File;
    .end local v12    # "readBytes":I
    :goto_4
    move-object v10, v9

    .line 368
    .end local v9    # "out":Ljava/io/BufferedOutputStream;
    .restart local v10    # "out":Ljava/io/BufferedOutputStream;
    goto :goto_1

    .line 369
    .end local v3    # "assetName":Ljava/lang/String;
    :cond_3
    :try_start_4
    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/adobe/air/ApplicationFileManager;->closeInputStream(Ljava/io/InputStream;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    move-object v9, v10

    .line 374
    .end local v10    # "out":Ljava/io/BufferedOutputStream;
    .restart local v9    # "out":Ljava/io/BufferedOutputStream;
    goto :goto_3

    .line 371
    .end local v5    # "entry":Ljava/util/zip/ZipEntry;
    .end local v9    # "out":Ljava/io/BufferedOutputStream;
    .restart local v10    # "out":Ljava/io/BufferedOutputStream;
    :catch_1
    move-exception v13

    move-object v9, v10

    .end local v10    # "out":Ljava/io/BufferedOutputStream;
    .restart local v9    # "out":Ljava/io/BufferedOutputStream;
    goto :goto_3

    .end local v9    # "out":Ljava/io/BufferedOutputStream;
    .restart local v3    # "assetName":Ljava/lang/String;
    .restart local v5    # "entry":Ljava/util/zip/ZipEntry;
    .restart local v10    # "out":Ljava/io/BufferedOutputStream;
    :cond_4
    move-object v9, v10

    .end local v10    # "out":Ljava/io/BufferedOutputStream;
    .restart local v9    # "out":Ljava/io/BufferedOutputStream;
    goto :goto_4
.end method

.method public deleteFile(Ljava/lang/String;)V
    .locals 1
    .param p1, "filePath"    # Ljava/lang/String;

    .prologue
    .line 168
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 169
    .local v0, "fileObj":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 170
    return-void
.end method

.method public fileExists(Ljava/lang/String;)Z
    .locals 3
    .param p1, "assetPath"    # Ljava/lang/String;

    .prologue
    .line 218
    const-string v1, ""

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "assets"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 220
    .local v0, "fPath":Ljava/lang/String;
    :goto_0
    iget-object v1, p0, Lcom/adobe/air/ApplicationFileManager;->mFileInfoMap:Ljava/util/HashMap;

    invoke-virtual {v1, v0}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v1, 0x1

    :goto_1
    return v1

    .line 218
    .end local v0    # "fPath":Ljava/lang/String;
    :cond_0
    const-string v0, "assets"

    goto :goto_0

    .line 220
    .restart local v0    # "fPath":Ljava/lang/String;
    :cond_1
    const/4 v1, 0x0

    goto :goto_1
.end method

.method public getLSize(Ljava/lang/String;)J
    .locals 6
    .param p1, "assetPath"    # Ljava/lang/String;

    .prologue
    .line 236
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "assets"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 239
    .local v0, "fPath":Ljava/lang/String;
    iget-object v2, p0, Lcom/adobe/air/ApplicationFileManager;->mFileInfoMap:Ljava/util/HashMap;

    invoke-virtual {v2, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/adobe/air/FileInfo;

    .line 240
    .local v1, "fileInfo":Lcom/adobe/air/FileInfo;
    if-eqz v1, :cond_0

    iget-wide v2, v1, Lcom/adobe/air/FileInfo;->mFileSize:J

    const-wide/16 v4, -0x1

    cmp-long v2, v2, v4

    if-eqz v2, :cond_0

    .line 241
    iget-wide v2, v1, Lcom/adobe/air/FileInfo;->mFileSize:J

    .line 243
    :goto_0
    return-wide v2

    :cond_0
    const-wide/16 v2, 0x0

    goto :goto_0
.end method

.method public isDirectory(Ljava/lang/String;)Z
    .locals 4
    .param p1, "assetPath"    # Ljava/lang/String;

    .prologue
    .line 227
    const-string v2, ""

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "assets"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 228
    .local v0, "fPath":Ljava/lang/String;
    :goto_0
    iget-object v2, p0, Lcom/adobe/air/ApplicationFileManager;->mFileInfoMap:Ljava/util/HashMap;

    invoke-virtual {v2, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/adobe/air/FileInfo;

    .line 230
    .local v1, "fileInfo":Lcom/adobe/air/FileInfo;
    if-eqz v1, :cond_1

    iget-boolean v2, v1, Lcom/adobe/air/FileInfo;->mIsDirectory:Z

    if-eqz v2, :cond_1

    const/4 v2, 0x1

    :goto_1
    return v2

    .line 227
    .end local v0    # "fPath":Ljava/lang/String;
    .end local v1    # "fileInfo":Lcom/adobe/air/FileInfo;
    :cond_0
    const-string v0, "assets"

    goto :goto_0

    .line 230
    .restart local v0    # "fPath":Ljava/lang/String;
    .restart local v1    # "fileInfo":Lcom/adobe/air/FileInfo;
    :cond_1
    const/4 v2, 0x0

    goto :goto_1
.end method

.method public procZipContents(Ljava/io/File;)V
    .locals 12
    .param p1, "apkPath"    # Ljava/io/File;

    .prologue
    .line 177
    :try_start_0
    new-instance v7, Ljava/util/zip/ZipFile;

    invoke-direct {v7, p1}, Ljava/util/zip/ZipFile;-><init>(Ljava/io/File;)V

    .line 178
    .local v7, "zip":Ljava/util/zip/ZipFile;
    invoke-virtual {v7}, Ljava/util/zip/ZipFile;->entries()Ljava/util/Enumeration;

    move-result-object v4

    .line 180
    .local v4, "enumEntry":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    :cond_0
    invoke-interface {v4}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v8

    if-eqz v8, :cond_1

    .line 182
    invoke-interface {v4}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/zip/ZipEntry;

    .line 183
    .local v3, "entry":Ljava/util/zip/ZipEntry;
    invoke-virtual {v3}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v2

    .line 186
    .local v2, "assetName":Ljava/lang/String;
    const/4 v8, 0x0

    const-string v9, "assets"

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v9

    invoke-virtual {v2, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    const-string v9, "assets"

    invoke-virtual {v8, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_0

    .line 190
    new-instance v5, Lcom/adobe/air/FileInfo;

    invoke-virtual {v3}, Ljava/util/zip/ZipEntry;->getSize()J

    move-result-wide v8

    const/4 v10, 0x1

    const/4 v11, 0x0

    invoke-direct {v5, v8, v9, v10, v11}, Lcom/adobe/air/FileInfo;-><init>(JZZ)V

    .line 191
    .local v5, "fileInfo":Lcom/adobe/air/FileInfo;
    iget-object v8, p0, Lcom/adobe/air/ApplicationFileManager;->mFileInfoMap:Ljava/util/HashMap;

    invoke-virtual {v8, v2, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 194
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .local v0, "assetFile":Ljava/io/File;
    move-object v1, v0

    .line 195
    .end local v0    # "assetFile":Ljava/io/File;
    .local v1, "assetFile":Ljava/io/File;
    :goto_0
    invoke-virtual {v1}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v8

    if-eqz v8, :cond_0

    .line 197
    iget-object v8, p0, Lcom/adobe/air/ApplicationFileManager;->mFileInfoMap:Ljava/util/HashMap;

    invoke-virtual {v1}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/adobe/air/FileInfo;

    .line 198
    .local v6, "parentFileInfo":Lcom/adobe/air/FileInfo;
    if-nez v6, :cond_0

    .line 200
    new-instance v6, Lcom/adobe/air/FileInfo;

    .end local v6    # "parentFileInfo":Lcom/adobe/air/FileInfo;
    const-wide/16 v8, -0x1

    const/4 v10, 0x0

    const/4 v11, 0x1

    invoke-direct {v6, v8, v9, v10, v11}, Lcom/adobe/air/FileInfo;-><init>(JZZ)V

    .line 201
    .restart local v6    # "parentFileInfo":Lcom/adobe/air/FileInfo;
    iget-object v8, p0, Lcom/adobe/air/ApplicationFileManager;->mFileInfoMap:Ljava/util/HashMap;

    invoke-virtual {v1}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9, v6}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 202
    new-instance v0, Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v0, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .end local v1    # "assetFile":Ljava/io/File;
    .restart local v0    # "assetFile":Ljava/io/File;
    move-object v1, v0

    .line 203
    .end local v0    # "assetFile":Ljava/io/File;
    .restart local v1    # "assetFile":Ljava/io/File;
    goto :goto_0

    .line 205
    .end local v1    # "assetFile":Ljava/io/File;
    .end local v2    # "assetName":Ljava/lang/String;
    .end local v3    # "entry":Ljava/util/zip/ZipEntry;
    .end local v5    # "fileInfo":Lcom/adobe/air/FileInfo;
    .end local v6    # "parentFileInfo":Lcom/adobe/air/FileInfo;
    :cond_1
    invoke-virtual {v7}, Ljava/util/zip/ZipFile;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 211
    .end local v4    # "enumEntry":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    .end local v7    # "zip":Ljava/util/zip/ZipFile;
    :goto_1
    return-void

    .line 207
    :catch_0
    move-exception v8

    goto :goto_1
.end method

.method public readFileName(Ljava/lang/String;)Z
    .locals 20
    .param p1, "assetPath"    # Ljava/lang/String;

    .prologue
    .line 260
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    const-string v19, "assets"

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    sget-object v19, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-object/from16 v0, v18

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 261
    .local v8, "fPath":Ljava/lang/String;
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lcom/adobe/air/ApplicationFileManager;->getAndroidUnzipContentPath()Ljava/lang/String;

    move-result-object v19

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    sget-char v19, Ljava/io/File;->separatorChar:C

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 262
    .local v10, "fullDirPath":Ljava/lang/String;
    new-instance v2, Ljava/io/File;

    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v18

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-direct {v2, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 263
    .local v2, "actualFile":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v18

    if-eqz v18, :cond_0

    .line 265
    const/16 v18, 0x1

    .line 328
    :goto_0
    return v18

    .line 270
    :cond_0
    invoke-direct/range {p0 .. p0}, Lcom/adobe/air/ApplicationFileManager;->getApkPathFile()Ljava/io/File;

    move-result-object v3

    .line 271
    .local v3, "apkPath":Ljava/io/File;
    const/4 v12, 0x0

    .line 272
    .local v12, "out":Ljava/io/BufferedOutputStream;
    const/16 v16, 0x0

    .line 276
    .local v16, "zip":Ljava/util/zip/ZipFile;
    :try_start_0
    new-instance v17, Ljava/util/zip/ZipFile;

    move-object/from16 v0, v17

    invoke-direct {v0, v3}, Ljava/util/zip/ZipFile;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_5
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 277
    .end local v16    # "zip":Ljava/util/zip/ZipFile;
    .local v17, "zip":Ljava/util/zip/ZipFile;
    :try_start_1
    invoke-virtual/range {v17 .. v17}, Ljava/util/zip/ZipFile;->entries()Ljava/util/Enumeration;

    move-result-object v7

    .line 279
    .local v7, "enumEntry":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    :cond_1
    invoke-interface {v7}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v18

    if-eqz v18, :cond_4

    .line 281
    invoke-interface {v7}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/zip/ZipEntry;

    .line 283
    .local v6, "entry":Ljava/util/zip/ZipEntry;
    invoke-virtual {v6}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v4

    .line 286
    .local v4, "assetName":Ljava/lang/String;
    const/16 v18, 0x0

    const-string v19, "assets"

    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->length()I

    move-result v19

    move/from16 v0, v18

    move/from16 v1, v19

    invoke-virtual {v4, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v18

    const-string v19, "assets"

    invoke-virtual/range {v18 .. v19}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v18

    if-eqz v18, :cond_1

    .line 289
    invoke-virtual {v4, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v18

    if-eqz v18, :cond_6

    .line 291
    move-object/from16 v0, v17

    invoke-virtual {v0, v6}, Ljava/util/zip/ZipFile;->getInputStream(Ljava/util/zip/ZipEntry;)Ljava/io/InputStream;

    move-result-object v11

    .line 292
    .local v11, "in":Ljava/io/InputStream;
    new-instance v14, Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-direct {v14, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 293
    .local v14, "parentFolderHierarchy":Ljava/io/File;
    invoke-virtual {v14}, Ljava/io/File;->mkdirs()Z

    .line 295
    new-instance v13, Ljava/io/BufferedOutputStream;

    new-instance v18, Ljava/io/FileOutputStream;

    move-object/from16 v0, v18

    invoke-direct {v0, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    const/16 v19, 0x2000

    move-object/from16 v0, v18

    move/from16 v1, v19

    invoke-direct {v13, v0, v1}, Ljava/io/BufferedOutputStream;-><init>(Ljava/io/OutputStream;I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 296
    .end local v12    # "out":Ljava/io/BufferedOutputStream;
    .local v13, "out":Ljava/io/BufferedOutputStream;
    const/16 v18, 0x2000

    :try_start_2
    move/from16 v0, v18

    new-array v5, v0, [B

    .line 297
    .local v5, "data":[B
    const/4 v15, 0x0

    .line 298
    .local v15, "readBytes":I
    :goto_1
    invoke-virtual {v11, v5}, Ljava/io/InputStream;->read([B)I

    move-result v15

    const/16 v18, -0x1

    move/from16 v0, v18

    if-eq v15, v0, :cond_3

    .line 300
    const/16 v18, 0x0

    move/from16 v0, v18

    invoke-virtual {v13, v5, v0, v15}, Ljava/io/BufferedOutputStream;->write([BII)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_1

    .line 316
    .end local v5    # "data":[B
    .end local v15    # "readBytes":I
    :catch_0
    move-exception v18

    move-object/from16 v16, v17

    .end local v17    # "zip":Ljava/util/zip/ZipFile;
    .restart local v16    # "zip":Ljava/util/zip/ZipFile;
    move-object v12, v13

    .line 321
    .end local v4    # "assetName":Ljava/lang/String;
    .end local v6    # "entry":Ljava/util/zip/ZipEntry;
    .end local v7    # "enumEntry":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    .end local v11    # "in":Ljava/io/InputStream;
    .end local v13    # "out":Ljava/io/BufferedOutputStream;
    .end local v14    # "parentFolderHierarchy":Ljava/io/File;
    .restart local v12    # "out":Ljava/io/BufferedOutputStream;
    :goto_2
    if-eqz v16, :cond_2

    .line 322
    :try_start_3
    invoke-virtual/range {v16 .. v16}, Ljava/util/zip/ZipFile;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    .line 328
    :cond_2
    :goto_3
    const/16 v18, 0x1

    goto/16 :goto_0

    .line 302
    .end local v12    # "out":Ljava/io/BufferedOutputStream;
    .end local v16    # "zip":Ljava/util/zip/ZipFile;
    .restart local v4    # "assetName":Ljava/lang/String;
    .restart local v5    # "data":[B
    .restart local v6    # "entry":Ljava/util/zip/ZipEntry;
    .restart local v7    # "enumEntry":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    .restart local v11    # "in":Ljava/io/InputStream;
    .restart local v13    # "out":Ljava/io/BufferedOutputStream;
    .restart local v14    # "parentFolderHierarchy":Ljava/io/File;
    .restart local v15    # "readBytes":I
    .restart local v17    # "zip":Ljava/util/zip/ZipFile;
    :cond_3
    :try_start_4
    move-object/from16 v0, p0

    invoke-direct {v0, v11}, Lcom/adobe/air/ApplicationFileManager;->closeInputStream(Ljava/io/InputStream;)V

    .line 303
    move-object/from16 v0, p0

    invoke-direct {v0, v13}, Lcom/adobe/air/ApplicationFileManager;->closeOutputStream(Ljava/io/OutputStream;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    move-object v12, v13

    .line 321
    .end local v4    # "assetName":Ljava/lang/String;
    .end local v5    # "data":[B
    .end local v6    # "entry":Ljava/util/zip/ZipEntry;
    .end local v11    # "in":Ljava/io/InputStream;
    .end local v13    # "out":Ljava/io/BufferedOutputStream;
    .end local v14    # "parentFolderHierarchy":Ljava/io/File;
    .end local v15    # "readBytes":I
    .restart local v12    # "out":Ljava/io/BufferedOutputStream;
    :cond_4
    :goto_4
    if-eqz v17, :cond_5

    .line 322
    :try_start_5
    invoke-virtual/range {v17 .. v17}, Ljava/util/zip/ZipFile;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2

    :cond_5
    move-object/from16 v16, v17

    .line 325
    .end local v17    # "zip":Ljava/util/zip/ZipFile;
    .restart local v16    # "zip":Ljava/util/zip/ZipFile;
    goto :goto_3

    .line 306
    .end local v16    # "zip":Ljava/util/zip/ZipFile;
    .restart local v4    # "assetName":Ljava/lang/String;
    .restart local v6    # "entry":Ljava/util/zip/ZipEntry;
    .restart local v17    # "zip":Ljava/util/zip/ZipFile;
    :cond_6
    :try_start_6
    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v18

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    const-string v19, "/"

    invoke-virtual/range {v18 .. v19}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v4, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v18

    if-eqz v18, :cond_1

    .line 310
    new-instance v9, Ljava/io/File;

    new-instance v18, Ljava/lang/StringBuilder;

    invoke-direct/range {v18 .. v18}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v18

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-virtual {v0, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v18

    invoke-virtual/range {v18 .. v18}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v18

    move-object/from16 v0, v18

    invoke-direct {v9, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 311
    .local v9, "folderHierarchy":Ljava/io/File;
    invoke-virtual {v9}, Ljava/io/File;->mkdirs()Z
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1
    .catchall {:try_start_6 .. :try_end_6} :catchall_1

    goto :goto_4

    .line 316
    .end local v4    # "assetName":Ljava/lang/String;
    .end local v6    # "entry":Ljava/util/zip/ZipEntry;
    .end local v7    # "enumEntry":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    .end local v9    # "folderHierarchy":Ljava/io/File;
    :catch_1
    move-exception v18

    move-object/from16 v16, v17

    .end local v17    # "zip":Ljava/util/zip/ZipFile;
    .restart local v16    # "zip":Ljava/util/zip/ZipFile;
    goto :goto_2

    .line 323
    .end local v16    # "zip":Ljava/util/zip/ZipFile;
    .restart local v7    # "enumEntry":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    .restart local v17    # "zip":Ljava/util/zip/ZipFile;
    :catch_2
    move-exception v18

    move-object/from16 v16, v17

    .line 326
    .end local v17    # "zip":Ljava/util/zip/ZipFile;
    .restart local v16    # "zip":Ljava/util/zip/ZipFile;
    goto :goto_3

    .line 320
    .end local v7    # "enumEntry":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    :catchall_0
    move-exception v18

    .line 321
    :goto_5
    if-eqz v16, :cond_7

    .line 322
    :try_start_7
    invoke-virtual/range {v16 .. v16}, Ljava/util/zip/ZipFile;->close()V
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_4

    .line 325
    :cond_7
    :goto_6
    throw v18

    .line 323
    :catch_3
    move-exception v18

    goto :goto_3

    :catch_4
    move-exception v19

    goto :goto_6

    .line 320
    .end local v16    # "zip":Ljava/util/zip/ZipFile;
    .restart local v17    # "zip":Ljava/util/zip/ZipFile;
    :catchall_1
    move-exception v18

    move-object/from16 v16, v17

    .end local v17    # "zip":Ljava/util/zip/ZipFile;
    .restart local v16    # "zip":Ljava/util/zip/ZipFile;
    goto :goto_5

    .end local v12    # "out":Ljava/io/BufferedOutputStream;
    .end local v16    # "zip":Ljava/util/zip/ZipFile;
    .restart local v4    # "assetName":Ljava/lang/String;
    .restart local v6    # "entry":Ljava/util/zip/ZipEntry;
    .restart local v7    # "enumEntry":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    .restart local v11    # "in":Ljava/io/InputStream;
    .restart local v13    # "out":Ljava/io/BufferedOutputStream;
    .restart local v14    # "parentFolderHierarchy":Ljava/io/File;
    .restart local v17    # "zip":Ljava/util/zip/ZipFile;
    :catchall_2
    move-exception v18

    move-object/from16 v16, v17

    .end local v17    # "zip":Ljava/util/zip/ZipFile;
    .restart local v16    # "zip":Ljava/util/zip/ZipFile;
    move-object v12, v13

    .end local v13    # "out":Ljava/io/BufferedOutputStream;
    .restart local v12    # "out":Ljava/io/BufferedOutputStream;
    goto :goto_5

    .line 316
    .end local v4    # "assetName":Ljava/lang/String;
    .end local v6    # "entry":Ljava/util/zip/ZipEntry;
    .end local v7    # "enumEntry":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    .end local v11    # "in":Ljava/io/InputStream;
    .end local v14    # "parentFolderHierarchy":Ljava/io/File;
    :catch_5
    move-exception v18

    goto :goto_2
.end method

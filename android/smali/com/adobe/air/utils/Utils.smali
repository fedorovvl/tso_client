.class public Lcom/adobe/air/utils/Utils;
.super Ljava/lang/Object;
.source "Utils.java"


# static fields
.field private static sRuntimePackageName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static GetExternalStorageDirectory()Ljava/lang/String;
    .locals 1

    .prologue
    .line 276
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static GetLayoutView(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/LayoutInflater;)Landroid/view/View;
    .locals 4
    .param p0, "type"    # Ljava/lang/String;
    .param p1, "resources"    # Landroid/content/res/Resources;
    .param p2, "inf"    # Landroid/view/LayoutInflater;

    .prologue
    const/4 v2, 0x0

    .line 244
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v3

    invoke-virtual {v3}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 245
    .local v0, "packageName":Ljava/lang/String;
    const-string v3, "layout"

    invoke-virtual {p1, p0, v3, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 246
    .local v1, "resourceId":I
    if-eqz v1, :cond_0

    .line 248
    invoke-virtual {p2, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    .line 250
    :cond_0
    return-object v2
.end method

.method public static GetLayoutViewFromRuntime(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/LayoutInflater;)Landroid/view/View;
    .locals 4
    .param p0, "type"    # Ljava/lang/String;
    .param p1, "resources"    # Landroid/content/res/Resources;
    .param p2, "inf"    # Landroid/view/LayoutInflater;

    .prologue
    const/4 v1, 0x0

    .line 234
    const-string v2, "layout"

    sget-object v3, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    invoke-virtual {p1, p0, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 235
    .local v0, "resourceId":I
    if-eqz v0, :cond_0

    .line 237
    invoke-virtual {p2, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 239
    :cond_0
    return-object v1
.end method

.method public static GetLibCorePath(Landroid/content/Context;)Ljava/lang/String;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 286
    const-string v0, "libCore.so"

    invoke-static {p0, v0}, Lcom/adobe/air/utils/Utils;->GetNativeLibraryPath(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static GetLibSTLPath(Landroid/content/Context;)Ljava/lang/String;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 291
    const-string v0, "libc++_shared.so"

    invoke-static {p0, v0}, Lcom/adobe/air/utils/Utils;->GetNativeLibraryPath(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static GetNativeExtensionPath(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 12
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 341
    const/4 v4, 0x0

    .line 346
    .local v4, "nativeExtensionPath":Ljava/lang/String;
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v8

    .line 347
    .local v8, "pkg":Landroid/content/pm/PackageManager;
    sget-object v10, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    const/4 v11, 0x0

    invoke-virtual {v8, v10, v11}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v3

    .line 348
    .local v3, "info":Landroid/content/pm/ApplicationInfo;
    const-class v10, Landroid/content/pm/ApplicationInfo;

    const-string v11, "nativeLibraryDir"

    invoke-virtual {v10, v11}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    .line 349
    .local v6, "nativeLibDirField":Ljava/lang/reflect/Field;
    const-class v10, Landroid/content/pm/ApplicationInfo;

    const-string v11, "sourceDir"

    invoke-virtual {v10, v11}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2

    .line 351
    .local v2, "codePath":Ljava/lang/reflect/Field;
    iget-object v7, v3, Landroid/content/pm/ApplicationInfo;->nativeLibraryDir:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 352
    .local v7, "nativePath":Ljava/lang/String;
    const/4 v0, 0x0

    .line 354
    .local v0, "aneLib":Ljava/io/File;
    :try_start_1
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v7, p1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .end local v0    # "aneLib":Ljava/io/File;
    .local v1, "aneLib":Ljava/io/File;
    move-object v0, v1

    .line 361
    .end local v1    # "aneLib":Ljava/io/File;
    .restart local v0    # "aneLib":Ljava/io/File;
    :goto_0
    if-eqz v0, :cond_0

    :try_start_2
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v10

    if-eqz v10, :cond_0

    .line 364
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    move-object v5, v4

    .line 400
    .end local v0    # "aneLib":Ljava/io/File;
    .end local v2    # "codePath":Ljava/lang/reflect/Field;
    .end local v3    # "info":Landroid/content/pm/ApplicationInfo;
    .end local v4    # "nativeExtensionPath":Ljava/lang/String;
    .end local v6    # "nativeLibDirField":Ljava/lang/reflect/Field;
    .end local v7    # "nativePath":Ljava/lang/String;
    .end local v8    # "pkg":Landroid/content/pm/PackageManager;
    .local v5, "nativeExtensionPath":Ljava/lang/String;
    :goto_1
    return-object v5

    .line 372
    .end local v5    # "nativeExtensionPath":Ljava/lang/String;
    .restart local v0    # "aneLib":Ljava/io/File;
    .restart local v2    # "codePath":Ljava/lang/reflect/Field;
    .restart local v3    # "info":Landroid/content/pm/ApplicationInfo;
    .restart local v4    # "nativeExtensionPath":Ljava/lang/String;
    .restart local v6    # "nativeLibDirField":Ljava/lang/reflect/Field;
    .restart local v7    # "nativePath":Ljava/lang/String;
    .restart local v8    # "pkg":Landroid/content/pm/PackageManager;
    :cond_0
    if-eqz v6, :cond_1

    .line 374
    invoke-virtual {v2, v3}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/String;

    .line 376
    .local v9, "sourceDir":Ljava/lang/String;
    const-string v10, "/system/app/"

    invoke-virtual {v9, v10}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v10

    const/4 v11, 0x1

    if-ne v10, v11, :cond_3

    .line 378
    new-instance v5, Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "/system/lib/"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    sget-object v11, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "/"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v5, v10}, Ljava/lang/String;-><init>(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .end local v4    # "nativeExtensionPath":Ljava/lang/String;
    .restart local v5    # "nativeExtensionPath":Ljava/lang/String;
    move-object v4, v5

    .line 392
    .end local v0    # "aneLib":Ljava/io/File;
    .end local v2    # "codePath":Ljava/lang/reflect/Field;
    .end local v3    # "info":Landroid/content/pm/ApplicationInfo;
    .end local v5    # "nativeExtensionPath":Ljava/lang/String;
    .end local v6    # "nativeLibDirField":Ljava/lang/reflect/Field;
    .end local v7    # "nativePath":Ljava/lang/String;
    .end local v8    # "pkg":Landroid/content/pm/PackageManager;
    .end local v9    # "sourceDir":Ljava/lang/String;
    .restart local v4    # "nativeExtensionPath":Ljava/lang/String;
    :cond_1
    :goto_2
    if-nez v4, :cond_2

    .line 395
    new-instance v4, Ljava/lang/String;

    .end local v4    # "nativeExtensionPath":Ljava/lang/String;
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "/data/data/"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    sget-object v11, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "/lib/"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v4, v10}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .restart local v4    # "nativeExtensionPath":Ljava/lang/String;
    :cond_2
    move-object v5, v4

    .line 400
    .end local v4    # "nativeExtensionPath":Ljava/lang/String;
    .restart local v5    # "nativeExtensionPath":Ljava/lang/String;
    goto :goto_1

    .line 382
    .end local v5    # "nativeExtensionPath":Ljava/lang/String;
    .restart local v0    # "aneLib":Ljava/io/File;
    .restart local v2    # "codePath":Ljava/lang/reflect/Field;
    .restart local v3    # "info":Landroid/content/pm/ApplicationInfo;
    .restart local v4    # "nativeExtensionPath":Ljava/lang/String;
    .restart local v6    # "nativeLibDirField":Ljava/lang/reflect/Field;
    .restart local v7    # "nativePath":Ljava/lang/String;
    .restart local v8    # "pkg":Landroid/content/pm/PackageManager;
    .restart local v9    # "sourceDir":Ljava/lang/String;
    :cond_3
    :try_start_3
    new-instance v5, Ljava/lang/String;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "/data/data/"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "/lib/"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-direct {v5, v10}, Ljava/lang/String;-><init>(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .end local v4    # "nativeExtensionPath":Ljava/lang/String;
    .restart local v5    # "nativeExtensionPath":Ljava/lang/String;
    move-object v4, v5

    .end local v5    # "nativeExtensionPath":Ljava/lang/String;
    .restart local v4    # "nativeExtensionPath":Ljava/lang/String;
    goto :goto_2

    .line 386
    .end local v0    # "aneLib":Ljava/io/File;
    .end local v2    # "codePath":Ljava/lang/reflect/Field;
    .end local v3    # "info":Landroid/content/pm/ApplicationInfo;
    .end local v6    # "nativeLibDirField":Ljava/lang/reflect/Field;
    .end local v7    # "nativePath":Ljava/lang/String;
    .end local v8    # "pkg":Landroid/content/pm/PackageManager;
    .end local v9    # "sourceDir":Ljava/lang/String;
    :catch_0
    move-exception v10

    goto :goto_2

    .line 355
    .restart local v0    # "aneLib":Ljava/io/File;
    .restart local v2    # "codePath":Ljava/lang/reflect/Field;
    .restart local v3    # "info":Landroid/content/pm/ApplicationInfo;
    .restart local v6    # "nativeLibDirField":Ljava/lang/reflect/Field;
    .restart local v7    # "nativePath":Ljava/lang/String;
    .restart local v8    # "pkg":Landroid/content/pm/PackageManager;
    :catch_1
    move-exception v10

    goto/16 :goto_0
.end method

.method public static GetNativeLibraryPath(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;
    .locals 10
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 296
    const/4 v4, 0x0

    .line 301
    .local v4, "nativeLibraryPath":Ljava/lang/String;
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v6

    .line 302
    .local v6, "pkg":Landroid/content/pm/PackageManager;
    sget-object v8, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    const/4 v9, 0x0

    invoke-virtual {v6, v8, v9}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v2

    .line 303
    .local v2, "info":Landroid/content/pm/ApplicationInfo;
    const-class v8, Landroid/content/pm/ApplicationInfo;

    const-string v9, "nativeLibraryDir"

    invoke-virtual {v8, v9}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v3

    .line 304
    .local v3, "nativeLibDirField":Ljava/lang/reflect/Field;
    const-class v8, Landroid/content/pm/ApplicationInfo;

    const-string v9, "sourceDir"

    invoke-virtual {v8, v9}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    .line 306
    .local v0, "codePath":Ljava/lang/reflect/Field;
    if-eqz v3, :cond_0

    .line 308
    invoke-virtual {v0, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    .line 310
    .local v7, "sourceDir":Ljava/lang/String;
    const-string v8, "/system/app/"

    invoke-virtual {v7, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v8

    const/4 v9, 0x1

    if-ne v8, v9, :cond_2

    .line 312
    new-instance v5, Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "/system/lib/"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    sget-object v9, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "/"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v5, v8}, Ljava/lang/String;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v4    # "nativeLibraryPath":Ljava/lang/String;
    .local v5, "nativeLibraryPath":Ljava/lang/String;
    move-object v4, v5

    .line 327
    .end local v0    # "codePath":Ljava/lang/reflect/Field;
    .end local v2    # "info":Landroid/content/pm/ApplicationInfo;
    .end local v3    # "nativeLibDirField":Ljava/lang/reflect/Field;
    .end local v5    # "nativeLibraryPath":Ljava/lang/String;
    .end local v6    # "pkg":Landroid/content/pm/PackageManager;
    .end local v7    # "sourceDir":Ljava/lang/String;
    .restart local v4    # "nativeLibraryPath":Ljava/lang/String;
    :cond_0
    :goto_0
    if-nez v4, :cond_1

    .line 330
    new-instance v4, Ljava/lang/String;

    .end local v4    # "nativeLibraryPath":Ljava/lang/String;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "/data/data/"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    sget-object v9, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "/lib/"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-direct {v4, v8}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .line 335
    .restart local v4    # "nativeLibraryPath":Ljava/lang/String;
    :cond_1
    return-object v4

    .line 316
    .restart local v0    # "codePath":Ljava/lang/reflect/Field;
    .restart local v2    # "info":Landroid/content/pm/ApplicationInfo;
    .restart local v3    # "nativeLibDirField":Ljava/lang/reflect/Field;
    .restart local v6    # "pkg":Landroid/content/pm/PackageManager;
    .restart local v7    # "sourceDir":Ljava/lang/String;
    :cond_2
    :try_start_1
    invoke-virtual {v3, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 317
    .local v1, "dir":Ljava/lang/String;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "/"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v8}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v4

    goto :goto_0

    .line 321
    .end local v0    # "codePath":Ljava/lang/reflect/Field;
    .end local v1    # "dir":Ljava/lang/String;
    .end local v2    # "info":Landroid/content/pm/ApplicationInfo;
    .end local v3    # "nativeLibDirField":Ljava/lang/reflect/Field;
    .end local v6    # "pkg":Landroid/content/pm/PackageManager;
    .end local v7    # "sourceDir":Ljava/lang/String;
    :catch_0
    move-exception v8

    goto :goto_0
.end method

.method public static GetResourceString(Ljava/lang/String;Landroid/content/res/Resources;)Ljava/lang/String;
    .locals 3
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "resources"    # Landroid/content/res/Resources;

    .prologue
    .line 269
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v2

    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 270
    .local v0, "packageName":Ljava/lang/String;
    const-string v2, "string"

    invoke-virtual {p1, p0, v2, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 271
    .local v1, "resourceId":I
    invoke-virtual {p1, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v2

    return-object v2
.end method

.method public static GetResourceStringFromRuntime(Ljava/lang/String;Landroid/content/res/Resources;)Ljava/lang/String;
    .locals 3
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "resources"    # Landroid/content/res/Resources;

    .prologue
    .line 222
    const-string v1, "string"

    sget-object v2, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    invoke-virtual {p1, p0, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 223
    .local v0, "resourceId":I
    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public static GetSharedDataDirectory()Ljava/lang/String;
    .locals 1

    .prologue
    .line 281
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static GetTelemetrySettings(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "telemetryFileName"    # Ljava/lang/String;
    .param p2, "monocleCompanionAppId"    # Ljava/lang/String;

    .prologue
    .line 405
    const/4 v2, 0x0

    .line 409
    .local v2, "settings":Ljava/lang/String;
    const/4 v3, 0x0

    .line 410
    .local v3, "sos":Ljava/io/ByteArrayOutputStream;
    const/4 v5, 0x0

    .line 413
    .local v5, "stream":Ljava/io/InputStream;
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    invoke-virtual {v6}, Landroid/content/res/Resources;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v6

    const/4 v7, 0x1

    invoke-virtual {v6, p1, v7}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;I)Ljava/io/InputStream;

    move-result-object v5

    .line 414
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v4}, Ljava/io/ByteArrayOutputStream;-><init>()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 415
    .end local v3    # "sos":Ljava/io/ByteArrayOutputStream;
    .local v4, "sos":Ljava/io/ByteArrayOutputStream;
    :try_start_1
    invoke-static {v5, v4}, Lcom/adobe/air/utils/Utils;->copyTo(Ljava/io/InputStream;Ljava/io/OutputStream;)V

    .line 417
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toString()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_5
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v2

    .line 426
    if-eqz v5, :cond_0

    .line 427
    :try_start_2
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    .line 428
    :cond_0
    if-eqz v4, :cond_1

    .line 429
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    :cond_1
    move-object v3, v4

    .line 435
    .end local v4    # "sos":Ljava/io/ByteArrayOutputStream;
    .restart local v3    # "sos":Ljava/io/ByteArrayOutputStream;
    :cond_2
    :goto_0
    if-nez v2, :cond_3

    .line 441
    const/4 v6, 0x0

    :try_start_3
    invoke-virtual {p0, p2, v6}, Landroid/content/Context;->createPackageContext(Ljava/lang/String;I)Landroid/content/Context;

    move-result-object v0

    .line 442
    .local v0, "monocleContext":Landroid/content/Context;
    const-string v6, "telemetry"

    const/4 v7, 0x1

    invoke-virtual {v0, v6, v7}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 443
    .local v1, "pref":Landroid/content/SharedPreferences;
    const-string v6, "content"

    const-string v7, ""

    invoke-interface {v1, v6, v7}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    move-result-object v2

    .line 451
    .end local v0    # "monocleContext":Landroid/content/Context;
    .end local v1    # "pref":Landroid/content/SharedPreferences;
    :cond_3
    :goto_1
    return-object v2

    .line 430
    .end local v3    # "sos":Ljava/io/ByteArrayOutputStream;
    .restart local v4    # "sos":Ljava/io/ByteArrayOutputStream;
    :catch_0
    move-exception v6

    move-object v3, v4

    .line 433
    .end local v4    # "sos":Ljava/io/ByteArrayOutputStream;
    .restart local v3    # "sos":Ljava/io/ByteArrayOutputStream;
    goto :goto_0

    .line 419
    :catch_1
    move-exception v6

    .line 426
    :goto_2
    if-eqz v5, :cond_4

    .line 427
    :try_start_4
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    .line 428
    :cond_4
    if-eqz v3, :cond_2

    .line 429
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_0

    .line 430
    :catch_2
    move-exception v6

    goto :goto_0

    .line 425
    :catchall_0
    move-exception v6

    .line 426
    :goto_3
    if-eqz v5, :cond_5

    .line 427
    :try_start_5
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V

    .line 428
    :cond_5
    if-eqz v3, :cond_6

    .line 429
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_4

    .line 432
    :cond_6
    :goto_4
    throw v6

    .line 445
    :catch_3
    move-exception v6

    goto :goto_1

    .line 430
    :catch_4
    move-exception v7

    goto :goto_4

    .line 425
    .end local v3    # "sos":Ljava/io/ByteArrayOutputStream;
    .restart local v4    # "sos":Ljava/io/ByteArrayOutputStream;
    :catchall_1
    move-exception v6

    move-object v3, v4

    .end local v4    # "sos":Ljava/io/ByteArrayOutputStream;
    .restart local v3    # "sos":Ljava/io/ByteArrayOutputStream;
    goto :goto_3

    .line 419
    .end local v3    # "sos":Ljava/io/ByteArrayOutputStream;
    .restart local v4    # "sos":Ljava/io/ByteArrayOutputStream;
    :catch_5
    move-exception v6

    move-object v3, v4

    .end local v4    # "sos":Ljava/io/ByteArrayOutputStream;
    .restart local v3    # "sos":Ljava/io/ByteArrayOutputStream;
    goto :goto_2
.end method

.method public static GetWidgetInView(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;
    .locals 3
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "resources"    # Landroid/content/res/Resources;
    .param p2, "view"    # Landroid/view/View;

    .prologue
    .line 262
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v2

    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 263
    .local v0, "packageName":Ljava/lang/String;
    const-string v2, "id"

    invoke-virtual {p1, p0, v2, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 264
    .local v1, "resourceId":I
    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    return-object v2
.end method

.method public static GetWidgetInViewByName(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;
    .locals 3
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "resources"    # Landroid/content/res/Resources;
    .param p2, "view"    # Landroid/view/View;

    .prologue
    .line 228
    const-string v1, "id"

    sget-object v2, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    invoke-virtual {p1, p0, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 229
    .local v0, "resourceId":I
    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    return-object v1
.end method

.method public static GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;
    .locals 3
    .param p0, "name"    # Ljava/lang/String;
    .param p1, "resources"    # Landroid/content/res/Resources;
    .param p2, "view"    # Landroid/view/View;

    .prologue
    .line 255
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v2

    invoke-virtual {v2}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v0

    .line 256
    .local v0, "packageName":Ljava/lang/String;
    const-string v2, "id"

    invoke-virtual {p1, p0, v2, v0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    .line 257
    .local v1, "resourceId":I
    invoke-virtual {p2, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    return-object v2
.end method

.method static KillProcess()V
    .locals 1

    .prologue
    .line 80
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    invoke-static {v0}, Landroid/os/Process;->killProcess(I)V

    .line 81
    return-void
.end method

.method public static ReplaceTextContentWithStars(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p0, "text"    # Ljava/lang/String;

    .prologue
    .line 212
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    .line 213
    .local v1, "length":I
    new-array v2, v1, [C

    .line 214
    .local v2, "val":[C
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v1, :cond_0

    .line 215
    const/16 v3, 0x2a

    aput-char v3, v2, v0

    .line 214
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 216
    :cond_0
    new-instance p0, Ljava/lang/String;

    .end local p0    # "text":Ljava/lang/String;
    invoke-direct {p0, v2}, Ljava/lang/String;-><init>([C)V

    .line 217
    .restart local p0    # "text":Ljava/lang/String;
    return-object p0
.end method

.method public static copyTo(Ljava/io/File;Ljava/io/File;)V
    .locals 8
    .param p0, "source"    # Ljava/io/File;
    .param p1, "dest"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 139
    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 141
    invoke-virtual {p1}, Ljava/io/File;->mkdirs()Z

    .line 142
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v5

    array-length v6, v5

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v6, :cond_1

    aget-object v3, v5, v4

    .line 144
    .local v3, "sourceChild":Ljava/io/File;
    new-instance v0, Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v0, p1, v7}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 145
    .local v0, "destChild":Ljava/io/File;
    invoke-static {v3, v0}, Lcom/adobe/air/utils/Utils;->copyTo(Ljava/io/File;Ljava/io/File;)V

    .line 142
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 150
    .end local v0    # "destChild":Ljava/io/File;
    .end local v3    # "sourceChild":Ljava/io/File;
    :cond_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 151
    .local v1, "in":Ljava/io/InputStream;
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 152
    .local v2, "out":Ljava/io/OutputStream;
    invoke-static {v1, v2}, Lcom/adobe/air/utils/Utils;->copyTo(Ljava/io/InputStream;Ljava/io/OutputStream;)V

    .line 153
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V

    .line 154
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    .line 156
    .end local v1    # "in":Ljava/io/InputStream;
    .end local v2    # "out":Ljava/io/OutputStream;
    :cond_1
    return-void
.end method

.method public static copyTo(Ljava/io/InputStream;Ljava/io/OutputStream;)V
    .locals 3
    .param p0, "in"    # Ljava/io/InputStream;
    .param p1, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 161
    const/16 v2, 0x400

    new-array v0, v2, [B

    .line 162
    .local v0, "buffer":[B
    :goto_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    .local v1, "read":I
    if-lez v1, :cond_0

    .line 163
    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Ljava/io/OutputStream;->write([BII)V

    goto :goto_0

    .line 165
    :cond_0
    return-void
.end method

.method public static getRuntimePackageName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 64
    sget-object v0, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    return-object v0
.end method

.method public static hasCaptiveRuntime()Z
    .locals 2

    .prologue
    .line 74
    const-string v0, "com.adobe.air"

    sget-object v1, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isNetworkAvailable(Landroid/content/Context;)Z
    .locals 4
    .param p0, "ctx"    # Landroid/content/Context;

    .prologue
    .line 456
    const-string v3, "connectivity"

    .line 457
    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 458
    .local v0, "cm":Landroid/net/ConnectivityManager;
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v2

    .line 460
    .local v2, "networkInfo":Landroid/net/NetworkInfo;
    const/4 v1, 0x0

    .line 463
    .local v1, "isConnected":Z
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 464
    const/4 v1, 0x1

    .line 466
    :cond_0
    return v1
.end method

.method public static native nativeConnectDebuggerSocket(Ljava/lang/String;)Z
.end method

.method public static parseKeyValuePairFile(Ljava/io/File;Ljava/lang/String;)Ljava/util/HashMap;
    .locals 1
    .param p0, "path"    # Ljava/io/File;
    .param p1, "delim"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    .line 179
    new-instance v0, Ljava/io/FileInputStream;

    invoke-direct {v0, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    invoke-static {v0, p1}, Lcom/adobe/air/utils/Utils;->parseKeyValuePairFile(Ljava/io/InputStream;Ljava/lang/String;)Ljava/util/HashMap;

    move-result-object v0

    return-object v0
.end method

.method public static parseKeyValuePairFile(Ljava/io/InputStream;Ljava/lang/String;)Ljava/util/HashMap;
    .locals 7
    .param p0, "stream"    # Ljava/io/InputStream;
    .param p1, "delim"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    .line 184
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 185
    .local v0, "keyValue":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v3, Ljava/util/Scanner;

    invoke-direct {v3, p0}, Ljava/util/Scanner;-><init>(Ljava/io/InputStream;)V

    .line 187
    .local v3, "scanner":Ljava/util/Scanner;
    :goto_0
    invoke-virtual {v3}, Ljava/util/Scanner;->hasNextLine()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 189
    new-instance v1, Ljava/util/Scanner;

    invoke-virtual {v3}, Ljava/util/Scanner;->nextLine()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v1, v5}, Ljava/util/Scanner;-><init>(Ljava/lang/String;)V

    .line 190
    .local v1, "lineScanner":Ljava/util/Scanner;
    invoke-virtual {v1, p1}, Ljava/util/Scanner;->useDelimiter(Ljava/lang/String;)Ljava/util/Scanner;

    .line 191
    invoke-virtual {v1}, Ljava/util/Scanner;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    .line 193
    invoke-virtual {v1}, Ljava/util/Scanner;->next()Ljava/lang/String;

    move-result-object v2

    .line 194
    .local v2, "name":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/util/Scanner;->next()Ljava/lang/String;

    move-result-object v4

    .line 195
    .local v4, "value":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v5, v6}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 197
    .end local v2    # "name":Ljava/lang/String;
    .end local v4    # "value":Ljava/lang/String;
    :cond_0
    invoke-virtual {v1}, Ljava/util/Scanner;->close()V

    goto :goto_0

    .line 199
    .end local v1    # "lineScanner":Ljava/util/Scanner;
    :cond_1
    invoke-virtual {v3}, Ljava/util/Scanner;->close()V

    .line 200
    return-object v0
.end method

.method public static setRuntimePackageName(Ljava/lang/String;)V
    .locals 0
    .param p0, "runtimePackageName"    # Ljava/lang/String;

    .prologue
    .line 68
    sput-object p0, Lcom/adobe/air/utils/Utils;->sRuntimePackageName:Ljava/lang/String;

    .line 69
    return-void
.end method

.method public static writeBufferToFile(Ljava/lang/StringBuffer;Ljava/io/File;)V
    .locals 2
    .param p0, "out"    # Ljava/lang/StringBuffer;
    .param p1, "path"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 168
    new-instance v0, Ljava/io/FileWriter;

    invoke-direct {v0, p1}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    .line 169
    .local v0, "buf":Ljava/io/FileWriter;
    invoke-virtual {p0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/FileWriter;->write(Ljava/lang/String;)V

    .line 170
    invoke-virtual {v0}, Ljava/io/FileWriter;->close()V

    .line 171
    return-void
.end method

.method public static writeOut(Ljava/io/InputStream;Ljava/io/File;)V
    .locals 1
    .param p0, "in"    # Ljava/io/InputStream;
    .param p1, "f"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 116
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 117
    .local v0, "out":Ljava/io/OutputStream;
    invoke-static {p0, v0}, Lcom/adobe/air/utils/Utils;->writeThrough(Ljava/io/InputStream;Ljava/io/OutputStream;)V

    .line 118
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    .line 119
    return-void
.end method

.method public static writeStringToFile(Ljava/lang/String;Ljava/io/File;)V
    .locals 1
    .param p0, "content"    # Ljava/lang/String;
    .param p1, "path"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 205
    new-instance v0, Ljava/io/FileWriter;

    invoke-direct {v0, p1}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    .line 206
    .local v0, "out":Ljava/io/FileWriter;
    invoke-virtual {v0, p0}, Ljava/io/FileWriter;->write(Ljava/lang/String;)V

    .line 207
    invoke-virtual {v0}, Ljava/io/FileWriter;->close()V

    .line 208
    return-void
.end method

.method public static writeStringToFile(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 7
    .param p0, "value"    # Ljava/lang/String;
    .param p1, "filePath"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    .line 87
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 88
    .local v1, "debuggerInfo":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_0

    .line 91
    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 97
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    .line 99
    .local v0, "data":[B
    :try_start_1
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 100
    .local v3, "pOut":Ljava/io/OutputStream;
    const/4 v5, 0x0

    array-length v6, v0

    invoke-virtual {v3, v0, v5, v6}, Ljava/io/OutputStream;->write([BII)V

    .line 101
    invoke-virtual {v3}, Ljava/io/OutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 106
    const/4 v4, 0x1

    .end local v0    # "data":[B
    .end local v3    # "pOut":Ljava/io/OutputStream;
    :goto_0
    return v4

    .line 92
    :catch_0
    move-exception v2

    .line 94
    .local v2, "e":Ljava/io/IOException;
    goto :goto_0

    .line 102
    .end local v2    # "e":Ljava/io/IOException;
    .restart local v0    # "data":[B
    :catch_1
    move-exception v2

    .line 104
    .restart local v2    # "e":Ljava/io/IOException;
    goto :goto_0
.end method

.method public static writeThrough(Ljava/io/InputStream;Ljava/io/OutputStream;)V
    .locals 3
    .param p0, "in"    # Ljava/io/InputStream;
    .param p1, "out"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    .line 128
    const/16 v2, 0x1000

    new-array v0, v2, [B

    .line 130
    .local v0, "buffer":[B
    :cond_0
    :goto_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    .local v1, "len":I
    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    .line 131
    if-eqz p1, :cond_0

    .line 132
    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Ljava/io/OutputStream;->write([BII)V

    .line 133
    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V

    goto :goto_0

    .line 136
    :cond_1
    return-void
.end method

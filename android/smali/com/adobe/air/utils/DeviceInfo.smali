.class public Lcom/adobe/air/utils/DeviceInfo;
.super Ljava/lang/Object;
.source "DeviceInfo.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static getCPUCount()Ljava/lang/String;
    .locals 12

    .prologue
    .line 78
    const/4 v10, 0x2

    :try_start_0
    new-array v0, v10, [Ljava/lang/String;

    const/4 v10, 0x0

    const-string v11, "/system/bin/cat"

    aput-object v11, v0, v10

    const/4 v10, 0x1

    const-string v11, "/sys/devices/system/cpu/present"

    aput-object v11, v0, v10

    .line 80
    .local v0, "args":[Ljava/lang/String;
    new-instance v2, Ljava/lang/ProcessBuilder;

    invoke-direct {v2, v0}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    .line 82
    .local v2, "cmd":Ljava/lang/ProcessBuilder;
    const/16 v10, 0x400

    new-array v1, v10, [B

    .line 83
    .local v1, "buf":[B
    invoke-virtual {v2}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object v6

    .line 84
    .local v6, "proc":Ljava/lang/Process;
    invoke-virtual {v6}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    .line 85
    .local v5, "is":Ljava/io/InputStream;
    const/4 v10, 0x0

    const/16 v11, 0x400

    invoke-virtual {v5, v1, v10, v11}, Ljava/io/InputStream;->read([BII)I

    move-result v3

    .line 86
    .local v3, "i":I
    if-ltz v3, :cond_1

    .line 88
    new-instance v7, Ljava/lang/String;

    const/4 v10, 0x0

    invoke-direct {v7, v1, v10, v3}, Ljava/lang/String;-><init>([BII)V

    .line 89
    .local v7, "s":Ljava/lang/String;
    const-string v10, "-"

    invoke-virtual {v7, v10}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    .line 90
    if-ltz v3, :cond_0

    .line 92
    add-int/lit8 v10, v3, 0x1

    add-int/lit8 v11, v3, 0x2

    invoke-virtual {v7, v10, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    .line 93
    .local v9, "strTempResult":Ljava/lang/String;
    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    .line 94
    .local v4, "intResult":I
    add-int/lit8 v10, v4, 0x1

    invoke-static {v10}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v8

    .line 111
    .end local v1    # "buf":[B
    .end local v2    # "cmd":Ljava/lang/ProcessBuilder;
    .end local v3    # "i":I
    .end local v4    # "intResult":I
    .end local v5    # "is":Ljava/io/InputStream;
    .end local v6    # "proc":Ljava/lang/Process;
    .end local v7    # "s":Ljava/lang/String;
    .end local v9    # "strTempResult":Ljava/lang/String;
    :goto_0
    return-object v8

    .line 99
    .restart local v1    # "buf":[B
    .restart local v2    # "cmd":Ljava/lang/ProcessBuilder;
    .restart local v3    # "i":I
    .restart local v5    # "is":Ljava/io/InputStream;
    .restart local v6    # "proc":Ljava/lang/Process;
    .restart local v7    # "s":Ljava/lang/String;
    :cond_0
    const/4 v10, 0x0

    const/4 v11, 0x1

    invoke-virtual {v7, v10, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    .line 100
    .restart local v9    # "strTempResult":Ljava/lang/String;
    invoke-static {v9}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v4

    .line 101
    .restart local v4    # "intResult":I
    add-int/lit8 v10, v4, 0x1

    invoke-static {v10}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v8

    .line 102
    .local v8, "strResult":Ljava/lang/String;
    goto :goto_0

    .line 107
    .end local v4    # "intResult":I
    .end local v7    # "s":Ljava/lang/String;
    .end local v8    # "strResult":Ljava/lang/String;
    .end local v9    # "strTempResult":Ljava/lang/String;
    :cond_1
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 111
    .end local v1    # "buf":[B
    .end local v2    # "cmd":Ljava/lang/ProcessBuilder;
    .end local v3    # "i":I
    .end local v5    # "is":Ljava/io/InputStream;
    .end local v6    # "proc":Ljava/lang/Process;
    :goto_1
    new-instance v8, Ljava/lang/String;

    const-string v10, ""

    invoke-direct {v8, v10}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    goto :goto_0

    .line 109
    :catch_0
    move-exception v10

    goto :goto_1
.end method

.method static getHardwareInfo()Ljava/lang/String;
    .locals 11

    .prologue
    .line 12
    const/4 v8, 0x2

    :try_start_0
    new-array v0, v8, [Ljava/lang/String;

    const/4 v8, 0x0

    const-string v9, "/system/bin/cat"

    aput-object v9, v0, v8

    const/4 v8, 0x1

    const-string v9, "/proc/cpuinfo"

    aput-object v9, v0, v8

    .line 14
    .local v0, "args":[Ljava/lang/String;
    new-instance v2, Ljava/lang/ProcessBuilder;

    invoke-direct {v2, v0}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    .line 16
    .local v2, "cmd":Ljava/lang/ProcessBuilder;
    const/16 v8, 0x400

    new-array v1, v8, [B

    .line 17
    .local v1, "buf":[B
    invoke-virtual {v2}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object v5

    .line 18
    .local v5, "proc":Ljava/lang/Process;
    invoke-virtual {v5}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    .line 19
    .local v4, "is":Ljava/io/InputStream;
    const/4 v8, 0x0

    const/16 v9, 0x400

    invoke-virtual {v4, v1, v8, v9}, Ljava/io/InputStream;->read([BII)I

    move-result v3

    .line 20
    .local v3, "i":I
    if-ltz v3, :cond_0

    .line 22
    new-instance v6, Ljava/lang/String;

    const/4 v8, 0x0

    invoke-direct {v6, v1, v8, v3}, Ljava/lang/String;-><init>([BII)V

    .line 23
    .local v6, "s":Ljava/lang/String;
    const-string v8, "Hardware"

    invoke-virtual {v6, v8}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    .line 24
    if-ltz v3, :cond_0

    .line 26
    const/16 v8, 0x3a

    invoke-virtual {v6, v8, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v3

    .line 27
    if-ltz v3, :cond_0

    .line 29
    add-int/lit8 v8, v3, 0x1

    const/16 v9, 0xa

    add-int/lit8 v10, v3, 0x1

    invoke-virtual {v6, v9, v10}, Ljava/lang/String;->indexOf(II)I

    move-result v9

    invoke-virtual {v6, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v7

    .line 39
    .end local v1    # "buf":[B
    .end local v2    # "cmd":Ljava/lang/ProcessBuilder;
    .end local v3    # "i":I
    .end local v4    # "is":Ljava/io/InputStream;
    .end local v5    # "proc":Ljava/lang/Process;
    .end local v6    # "s":Ljava/lang/String;
    :goto_0
    return-object v7

    .line 35
    .restart local v1    # "buf":[B
    .restart local v2    # "cmd":Ljava/lang/ProcessBuilder;
    .restart local v3    # "i":I
    .restart local v4    # "is":Ljava/io/InputStream;
    .restart local v5    # "proc":Ljava/lang/Process;
    :cond_0
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 39
    .end local v1    # "buf":[B
    .end local v2    # "cmd":Ljava/lang/ProcessBuilder;
    .end local v3    # "i":I
    .end local v4    # "is":Ljava/io/InputStream;
    .end local v5    # "proc":Ljava/lang/Process;
    :goto_1
    new-instance v7, Ljava/lang/String;

    const-string v8, ""

    invoke-direct {v7, v8}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    goto :goto_0

    .line 37
    :catch_0
    move-exception v8

    goto :goto_1
.end method

.method static getTotalMemory()Ljava/lang/String;
    .locals 11

    .prologue
    .line 45
    const/4 v8, 0x2

    :try_start_0
    new-array v0, v8, [Ljava/lang/String;

    const/4 v8, 0x0

    const-string v9, "/system/bin/cat"

    aput-object v9, v0, v8

    const/4 v8, 0x1

    const-string v9, "/proc/meminfo"

    aput-object v9, v0, v8

    .line 47
    .local v0, "args":[Ljava/lang/String;
    new-instance v2, Ljava/lang/ProcessBuilder;

    invoke-direct {v2, v0}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    .line 49
    .local v2, "cmd":Ljava/lang/ProcessBuilder;
    const/16 v8, 0x400

    new-array v1, v8, [B

    .line 50
    .local v1, "buf":[B
    invoke-virtual {v2}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object v5

    .line 51
    .local v5, "proc":Ljava/lang/Process;
    invoke-virtual {v5}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object v4

    .line 52
    .local v4, "is":Ljava/io/InputStream;
    const/4 v8, 0x0

    const/16 v9, 0x400

    invoke-virtual {v4, v1, v8, v9}, Ljava/io/InputStream;->read([BII)I

    move-result v3

    .line 53
    .local v3, "i":I
    if-ltz v3, :cond_0

    .line 55
    new-instance v6, Ljava/lang/String;

    const/4 v8, 0x0

    invoke-direct {v6, v1, v8, v3}, Ljava/lang/String;-><init>([BII)V

    .line 56
    .local v6, "s":Ljava/lang/String;
    const-string v8, "MemTotal"

    invoke-virtual {v6, v8}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    .line 57
    if-ltz v3, :cond_0

    .line 59
    const/16 v8, 0x3a

    invoke-virtual {v6, v8, v3}, Ljava/lang/String;->indexOf(II)I

    move-result v3

    .line 60
    if-ltz v3, :cond_0

    .line 62
    add-int/lit8 v8, v3, 0x1

    const/16 v9, 0xa

    add-int/lit8 v10, v3, 0x1

    invoke-virtual {v6, v9, v10}, Ljava/lang/String;->indexOf(II)I

    move-result v9

    invoke-virtual {v6, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v7

    .line 72
    .end local v1    # "buf":[B
    .end local v2    # "cmd":Ljava/lang/ProcessBuilder;
    .end local v3    # "i":I
    .end local v4    # "is":Ljava/io/InputStream;
    .end local v5    # "proc":Ljava/lang/Process;
    .end local v6    # "s":Ljava/lang/String;
    :goto_0
    return-object v7

    .line 68
    .restart local v1    # "buf":[B
    .restart local v2    # "cmd":Ljava/lang/ProcessBuilder;
    .restart local v3    # "i":I
    .restart local v4    # "is":Ljava/io/InputStream;
    .restart local v5    # "proc":Ljava/lang/Process;
    :cond_0
    invoke-virtual {v4}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 72
    .end local v1    # "buf":[B
    .end local v2    # "cmd":Ljava/lang/ProcessBuilder;
    .end local v3    # "i":I
    .end local v4    # "is":Ljava/io/InputStream;
    .end local v5    # "proc":Ljava/lang/Process;
    :goto_1
    new-instance v7, Ljava/lang/String;

    const-string v8, ""

    invoke-direct {v7, v8}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    goto :goto_0

    .line 70
    :catch_0
    move-exception v8

    goto :goto_1
.end method

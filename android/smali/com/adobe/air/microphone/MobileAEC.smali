.class public Lcom/adobe/air/microphone/MobileAEC;
.super Ljava/lang/Object;
.source "MobileAEC.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/microphone/MobileAEC$AecmConfig;,
        Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;,
        Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;
    }
.end annotation


# static fields
.field public static final AECM_ENABLE:S = 0x1s

.field public static final AECM_UNABLE:S


# instance fields
.field private mAecmConfig:Lcom/adobe/air/microphone/MobileAEC$AecmConfig;

.field private mAecmHandler:I

.field private mIsInit:Z

.field private mSampFreq:Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;


# direct methods
.method public constructor <init>(Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;)V
    .locals 2
    .param p1, "sampFreqOfData"    # Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;

    .prologue
    const/4 v1, 0x0

    .line 128
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 113
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmHandler:I

    .line 114
    iput-object v1, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmConfig:Lcom/adobe/air/microphone/MobileAEC$AecmConfig;

    .line 115
    iput-object v1, p0, Lcom/adobe/air/microphone/MobileAEC;->mSampFreq:Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;

    .line 116
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mIsInit:Z

    .line 129
    invoke-virtual {p0, p1}, Lcom/adobe/air/microphone/MobileAEC;->setSampFreq(Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;)V

    .line 130
    new-instance v0, Lcom/adobe/air/microphone/MobileAEC$AecmConfig;

    invoke-direct {v0, p0}, Lcom/adobe/air/microphone/MobileAEC$AecmConfig;-><init>(Lcom/adobe/air/microphone/MobileAEC;)V

    iput-object v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmConfig:Lcom/adobe/air/microphone/MobileAEC$AecmConfig;

    .line 133
    invoke-static {}, Lcom/adobe/air/microphone/MobileAEC;->nativeCreateAecmInstance()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmHandler:I

    .line 134
    return-void
.end method

.method private mInitAecmInstance(I)V
    .locals 2
    .param p1, "SampFreq"    # I

    .prologue
    .line 295
    iget-boolean v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mIsInit:Z

    if-nez v0, :cond_0

    .line 296
    iget v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmHandler:I

    invoke-static {v0, p1}, Lcom/adobe/air/microphone/MobileAEC;->nativeInitializeAecmInstance(II)I

    .line 299
    new-instance v0, Lcom/adobe/air/microphone/MobileAEC$AecmConfig;

    invoke-direct {v0, p0}, Lcom/adobe/air/microphone/MobileAEC$AecmConfig;-><init>(Lcom/adobe/air/microphone/MobileAEC;)V

    iput-object v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmConfig:Lcom/adobe/air/microphone/MobileAEC$AecmConfig;

    .line 302
    iget v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmHandler:I

    iget-object v1, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmConfig:Lcom/adobe/air/microphone/MobileAEC$AecmConfig;

    invoke-static {v0, v1}, Lcom/adobe/air/microphone/MobileAEC;->nativeSetConfig(ILcom/adobe/air/microphone/MobileAEC$AecmConfig;)I

    .line 304
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mIsInit:Z

    .line 306
    :cond_0
    return-void
.end method

.method private static native nativeAecmProcess(I[S[S[SSS)I
.end method

.method private static native nativeBufferFarend(I[SI)I
.end method

.method private static native nativeCreateAecmInstance()I
.end method

.method private static native nativeFreeAecmInstance(I)I
.end method

.method private static native nativeInitializeAecmInstance(II)I
.end method

.method private static native nativeSetConfig(ILcom/adobe/air/microphone/MobileAEC$AecmConfig;)I
.end method


# virtual methods
.method public close()V
    .locals 1

    .prologue
    .line 267
    iget-boolean v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mIsInit:Z

    if-eqz v0, :cond_0

    .line 268
    iget v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmHandler:I

    invoke-static {v0}, Lcom/adobe/air/microphone/MobileAEC;->nativeFreeAecmInstance(I)I

    .line 269
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmHandler:I

    .line 270
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mIsInit:Z

    .line 272
    :cond_0
    return-void
.end method

.method public echoCancellation([S[S[SSS)V
    .locals 6
    .param p1, "nearendNoisy"    # [S
    .param p2, "nearendClean"    # [S
    .param p3, "out"    # [S
    .param p4, "numOfSamples"    # S
    .param p5, "delay"    # S
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 208
    iget-boolean v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mIsInit:Z

    if-nez v0, :cond_0

    .line 210
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "echoCancelling() called on an unprepared AECM instance."

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 215
    :cond_0
    iget v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmHandler:I

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move v4, p4

    move v5, p5

    invoke-static/range {v0 .. v5}, Lcom/adobe/air/microphone/MobileAEC;->nativeAecmProcess(I[S[S[SSS)I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    .line 218
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "echoCancellation() failed due to invalid arguments."

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 220
    :cond_1
    return-void
.end method

.method public farendBuffer([SI)Lcom/adobe/air/microphone/MobileAEC;
    .locals 2
    .param p1, "farendBuf"    # [S
    .param p2, "numOfSamples"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 165
    iget-boolean v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mIsInit:Z

    if-nez v0, :cond_0

    .line 167
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "setFarendBuffer() called on an unprepared AECM instance."

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 171
    :cond_0
    iget v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmHandler:I

    invoke-static {v0, p1, p2}, Lcom/adobe/air/microphone/MobileAEC;->nativeBufferFarend(I[SI)I

    move-result v0

    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    .line 173
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "setFarendBuffer() failed due to invalid arguments."

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 176
    :cond_1
    return-object p0
.end method

.method protected finalize()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .prologue
    .line 279
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 281
    iget-boolean v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mIsInit:Z

    if-eqz v0, :cond_0

    .line 282
    invoke-virtual {p0}, Lcom/adobe/air/microphone/MobileAEC;->close()V

    .line 284
    :cond_0
    return-void
.end method

.method public prepare()Lcom/adobe/air/microphone/MobileAEC;
    .locals 2

    .prologue
    .line 248
    iget-boolean v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mIsInit:Z

    if-eqz v0, :cond_0

    .line 249
    invoke-virtual {p0}, Lcom/adobe/air/microphone/MobileAEC;->close()V

    .line 250
    invoke-static {}, Lcom/adobe/air/microphone/MobileAEC;->nativeCreateAecmInstance()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmHandler:I

    .line 253
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mSampFreq:Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;

    invoke-virtual {v0}, Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;->getFS()J

    move-result-wide v0

    long-to-int v0, v0

    invoke-direct {p0, v0}, Lcom/adobe/air/microphone/MobileAEC;->mInitAecmInstance(I)V

    .line 254
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mIsInit:Z

    .line 257
    iget v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmHandler:I

    iget-object v1, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmConfig:Lcom/adobe/air/microphone/MobileAEC$AecmConfig;

    invoke-static {v0, v1}, Lcom/adobe/air/microphone/MobileAEC;->nativeSetConfig(ILcom/adobe/air/microphone/MobileAEC$AecmConfig;)I

    .line 258
    return-object p0
.end method

.method public setAecmMode(Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;)Lcom/adobe/air/microphone/MobileAEC;
    .locals 2
    .param p1, "mode"    # Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NullPointerException;
        }
    .end annotation

    .prologue
    .line 233
    if-nez p1, :cond_0

    .line 234
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "setAecMode() failed due to null argument."

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 237
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mAecmConfig:Lcom/adobe/air/microphone/MobileAEC$AecmConfig;

    invoke-virtual {p1}, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->getMode()I

    move-result v1

    int-to-short v1, v1

    invoke-static {v0, v1}, Lcom/adobe/air/microphone/MobileAEC$AecmConfig;->access$002(Lcom/adobe/air/microphone/MobileAEC$AecmConfig;S)S

    .line 238
    return-object p0
.end method

.method public setSampFreq(Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;)V
    .locals 1
    .param p1, "fs"    # Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;

    .prologue
    .line 147
    if-nez p1, :cond_0

    .line 148
    sget-object v0, Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;->FS_16000Hz:Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;

    iput-object v0, p0, Lcom/adobe/air/microphone/MobileAEC;->mSampFreq:Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;

    .line 151
    :goto_0
    return-void

    .line 150
    :cond_0
    iput-object p1, p0, Lcom/adobe/air/microphone/MobileAEC;->mSampFreq:Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;

    goto :goto_0
.end method

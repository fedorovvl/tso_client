.class public Lcom/adobe/air/microphone/AIRMicrophoneRecorder;
.super Ljava/lang/Object;
.source "AIRMicrophoneRecorder.java"

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field public static final BLACKLIST:[Ljava/lang/String;


# instance fields
.field private echoCanceler:Landroid/media/audiofx/AcousticEchoCanceler;

.field private hardwareAEC:Z

.field private mBuffer_toWrite:Ljava/nio/ByteBuffer;

.field public volatile mKeepAlive:Z

.field private mMicBuffer:[B

.field private m_audioFormat:I

.field private m_audioSource:I

.field private m_bufferSize:I

.field private m_channelConfiguration:I

.field public m_delay:S

.field public m_isEnhancedMicrophone:Z

.field private volatile m_isPaused:Z

.field private volatile m_isRecording:Z

.field private m_recorder:Landroid/media/AudioRecord;

.field private m_sampleRate:I

.field private final mutex:Ljava/lang/Object;

.field private noiseSuppressor:Landroid/media/audiofx/NoiseSuppressor;

.field private t_analyze:J

.field private t_capture:J

.field private t_process:J

.field private t_render:J


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    .line 285
    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "Nexus 9"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "Nexus 10"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "ONE A2005"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "D6503"

    aput-object v2, v0, v1

    sput-object v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->BLACKLIST:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(IIIII)V
    .locals 4
    .param p1, "audioSource"    # I
    .param p2, "sampleRate"    # I
    .param p3, "channelConfig"    # I
    .param p4, "audioFormat"    # I
    .param p5, "bufferSize"    # I

    .prologue
    const/4 v0, 0x0

    const-wide/16 v2, 0x0

    const/4 v1, 0x0

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 298
    iput v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_audioSource:I

    .line 299
    iput v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_sampleRate:I

    .line 300
    iput v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_channelConfiguration:I

    .line 301
    iput v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_audioFormat:I

    .line 302
    iput v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_bufferSize:I

    .line 306
    iput-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->echoCanceler:Landroid/media/audiofx/AcousticEchoCanceler;

    .line 307
    iput-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->noiseSuppressor:Landroid/media/audiofx/NoiseSuppressor;

    .line 308
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mutex:Ljava/lang/Object;

    .line 309
    iput-boolean v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_isEnhancedMicrophone:Z

    .line 310
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mKeepAlive:Z

    .line 312
    iput-wide v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_render:J

    iput-wide v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_analyze:J

    iput-wide v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_process:J

    iput-wide v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_capture:J

    .line 313
    iput-short v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_delay:S

    .line 314
    iput-boolean v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->hardwareAEC:Z

    .line 34
    iput p1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_audioSource:I

    .line 35
    iput p2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_sampleRate:I

    .line 36
    iput p3, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_channelConfiguration:I

    .line 37
    iput p4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_audioFormat:I

    .line 38
    iput p5, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_bufferSize:I

    .line 39
    iget v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_bufferSize:I

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mMicBuffer:[B

    .line 40
    return-void
.end method

.method public static deviceIsBlackListed()Z
    .locals 2

    .prologue
    .line 293
    sget-object v1, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->BLACKLIST:[Ljava/lang/String;

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 294
    .local v0, "blacklisted":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method private doAECM()V
    .locals 18

    .prologue
    .line 210
    :try_start_0
    new-instance v2, Lcom/adobe/air/microphone/MobileAEC;

    const/4 v4, 0x0

    invoke-direct {v2, v4}, Lcom/adobe/air/microphone/MobileAEC;-><init>(Lcom/adobe/air/microphone/MobileAEC$SamplingFrequency;)V

    .line 211
    .local v2, "aecm":Lcom/adobe/air/microphone/MobileAEC;
    sget-object v4, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->MOST_AGGRESSIVE:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    invoke-virtual {v2, v4}, Lcom/adobe/air/microphone/MobileAEC;->setAecmMode(Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;)Lcom/adobe/air/microphone/MobileAEC;

    move-result-object v4

    invoke-virtual {v4}, Lcom/adobe/air/microphone/MobileAEC;->prepare()Lcom/adobe/air/microphone/MobileAEC;

    .line 214
    new-instance v11, Ljava/io/ByteArrayInputStream;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mMicBuffer:[B

    invoke-direct {v11, v4}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 215
    .local v11, "fin":Ljava/io/ByteArrayInputStream;
    new-instance v12, Ljava/io/ByteArrayOutputStream;

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mBuffer_toWrite:Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->capacity()I

    move-result v4

    invoke-direct {v12, v4}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 219
    .local v12, "fout":Ljava/io/ByteArrayOutputStream;
    const/16 v9, 0x140

    .line 220
    .local v9, "cacheSize":I
    const/16 v4, 0x140

    new-array v13, v4, [B

    .line 222
    .local v13, "pcmInputCache":[B
    :goto_0
    const/4 v4, 0x0

    array-length v6, v13

    invoke-virtual {v11, v13, v4, v6}, Ljava/io/ByteArrayInputStream;->read([BII)I

    move-result v4

    const/4 v6, -0x1

    if-eq v4, v6, :cond_0

    .line 224
    const/16 v4, 0xa0

    new-array v3, v4, [S

    .line 225
    .local v3, "aecTmpIn":[S
    const/16 v4, 0xa0

    new-array v5, v4, [S

    .line 226
    .local v5, "aecTmpOut":[S
    invoke-static {v13}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v4

    sget-object v6, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v4

    .line 227
    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->asShortBuffer()Ljava/nio/ShortBuffer;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/nio/ShortBuffer;->get([S)Ljava/nio/ShortBuffer;

    .line 232
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    move-object/from16 v0, p0

    iput-wide v6, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_analyze:J

    .line 233
    const/16 v4, 0xa0

    invoke-virtual {v2, v3, v4}, Lcom/adobe/air/microphone/MobileAEC;->farendBuffer([SI)Lcom/adobe/air/microphone/MobileAEC;

    .line 235
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    move-object/from16 v0, p0

    iput-wide v6, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_process:J

    .line 240
    move-object/from16 v0, p0

    iget-wide v6, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_render:J

    move-object/from16 v0, p0

    iget-wide v14, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_analyze:J

    sub-long/2addr v6, v14

    move-object/from16 v0, p0

    iget-wide v14, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_process:J

    move-object/from16 v0, p0

    iget-wide v0, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_capture:J

    move-wide/from16 v16, v0

    sub-long v14, v14, v16

    add-long/2addr v6, v14

    long-to-int v4, v6

    int-to-short v4, v4

    move-object/from16 v0, p0

    iput-short v4, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_delay:S

    .line 241
    const/16 v4, 0xc8

    move-object/from16 v0, p0

    iput-short v4, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_delay:S

    .line 243
    const/4 v4, 0x0

    const/16 v6, 0xa0

    move-object/from16 v0, p0

    iget-short v7, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_delay:S

    invoke-virtual/range {v2 .. v7}, Lcom/adobe/air/microphone/MobileAEC;->echoCancellation([S[S[SSS)V

    .line 247
    const/16 v4, 0x140

    new-array v8, v4, [B

    .line 248
    .local v8, "aecBuf":[B
    invoke-static {v8}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v4

    sget-object v6, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v4

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->asShortBuffer()Ljava/nio/ShortBuffer;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/nio/ShortBuffer;->put([S)Ljava/nio/ShortBuffer;

    .line 249
    const/4 v4, 0x0

    array-length v6, v8

    invoke-virtual {v12, v8, v4, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 262
    .end local v2    # "aecm":Lcom/adobe/air/microphone/MobileAEC;
    .end local v3    # "aecTmpIn":[S
    .end local v5    # "aecTmpOut":[S
    .end local v8    # "aecBuf":[B
    .end local v9    # "cacheSize":I
    .end local v11    # "fin":Ljava/io/ByteArrayInputStream;
    .end local v12    # "fout":Ljava/io/ByteArrayOutputStream;
    .end local v13    # "pcmInputCache":[B
    :catch_0
    move-exception v10

    .line 263
    .local v10, "e":Ljava/lang/Exception;
    invoke-virtual {v10}, Ljava/lang/Exception;->printStackTrace()V

    .line 265
    .end local v10    # "e":Ljava/lang/Exception;
    :goto_1
    return-void

    .line 255
    .restart local v2    # "aecm":Lcom/adobe/air/microphone/MobileAEC;
    .restart local v9    # "cacheSize":I
    .restart local v11    # "fin":Ljava/io/ByteArrayInputStream;
    .restart local v12    # "fout":Ljava/io/ByteArrayOutputStream;
    .restart local v13    # "pcmInputCache":[B
    :cond_0
    :try_start_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mBuffer_toWrite:Ljava/nio/ByteBuffer;

    invoke-virtual {v4}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 256
    invoke-virtual {v12}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v4

    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v4

    move-object/from16 v0, p0

    iput-object v4, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mBuffer_toWrite:Ljava/nio/ByteBuffer;

    .line 257
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mBuffer_toWrite:Ljava/nio/ByteBuffer;

    invoke-virtual {v12}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->put([B)Ljava/nio/ByteBuffer;

    .line 259
    invoke-virtual {v12}, Ljava/io/ByteArrayOutputStream;->close()V

    .line 260
    invoke-virtual {v11}, Ljava/io/ByteArrayInputStream;->close()V

    .line 261
    invoke-virtual {v2}, Lcom/adobe/air/microphone/MobileAEC;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1
.end method

.method public static getBlackListedModels()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 282
    sget-object v0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->BLACKLIST:[Ljava/lang/String;

    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public Open()Ljava/lang/Boolean;
    .locals 9

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 110
    iget v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_sampleRate:I

    iget v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_channelConfiguration:I

    iget v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_audioFormat:I

    invoke-static {v0, v1, v2}, Landroid/media/AudioRecord;->getMinBufferSize(III)I

    move-result v5

    .line 112
    .local v5, "bufferSize":I
    iget-boolean v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_isEnhancedMicrophone:Z

    if-eqz v0, :cond_1

    .line 119
    iget v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_bufferSize:I

    if-le v0, v5, :cond_0

    .line 120
    iget v5, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_bufferSize:I

    .line 124
    :goto_0
    iget v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_bufferSize:I

    invoke-static {v0}, Ljava/nio/ByteBuffer;->allocateDirect(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mBuffer_toWrite:Ljava/nio/ByteBuffer;

    .line 138
    :goto_1
    :try_start_0
    iget-boolean v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_isEnhancedMicrophone:Z

    if-eqz v0, :cond_3

    .line 139
    new-instance v0, Landroid/media/AudioRecord;

    const/4 v1, 0x7

    iget v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_sampleRate:I

    iget v3, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_channelConfiguration:I

    iget v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_audioFormat:I

    invoke-direct/range {v0 .. v5}, Landroid/media/AudioRecord;-><init>(IIIII)V

    iput-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 151
    :goto_2
    iget-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;

    if-eqz v0, :cond_4

    .line 152
    iget-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;

    invoke-virtual {v0}, Landroid/media/AudioRecord;->getState()I

    move-result v0

    if-ne v0, v8, :cond_4

    .line 154
    invoke-static {v8}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    .line 158
    :goto_3
    return-object v0

    .line 122
    :cond_0
    mul-int/lit8 v5, v5, 0x2

    goto :goto_0

    .line 128
    :cond_1
    iget v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_bufferSize:I

    if-le v0, v5, :cond_2

    .line 129
    iget v5, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_bufferSize:I

    goto :goto_1

    .line 131
    :cond_2
    mul-int/lit8 v5, v5, 0x2

    goto :goto_1

    .line 142
    :cond_3
    :try_start_1
    new-instance v0, Landroid/media/AudioRecord;

    iget v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_audioSource:I

    iget v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_sampleRate:I

    iget v3, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_channelConfiguration:I

    iget v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_audioFormat:I

    invoke-direct/range {v0 .. v5}, Landroid/media/AudioRecord;-><init>(IIIII)V

    iput-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;
    :try_end_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    .line 146
    :catch_0
    move-exception v6

    .line 148
    .local v6, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v6}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    .line 149
    invoke-static {v7}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    goto :goto_3

    .line 158
    .end local v6    # "e":Ljava/lang/IllegalArgumentException;
    :cond_4
    invoke-static {v7}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    goto :goto_3
.end method

.method public getBuffer()[B
    .locals 5

    .prologue
    .line 167
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_capture:J

    .line 169
    iget-object v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;

    iget-object v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mMicBuffer:[B

    const/4 v3, 0x0

    iget v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_bufferSize:I

    invoke-virtual {v1, v2, v3, v4}, Landroid/media/AudioRecord;->read([BII)I

    move-result v0

    .line 170
    .local v0, "result":I
    const/4 v1, -0x3

    if-ne v0, v1, :cond_3

    .line 180
    :cond_0
    :goto_0
    iget-boolean v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_isEnhancedMicrophone:Z

    const/4 v2, 0x1

    if-ne v1, v2, :cond_2

    iget-boolean v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->hardwareAEC:Z

    if-eqz v1, :cond_1

    invoke-static {}, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->deviceIsBlackListed()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 181
    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iput-wide v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->t_render:J

    .line 182
    invoke-direct {p0}, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->doAECM()V

    .line 183
    iget-object v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mBuffer_toWrite:Ljava/nio/ByteBuffer;

    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v1

    iget v2, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_bufferSize:I

    invoke-static {v1, v2}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mMicBuffer:[B

    .line 185
    :cond_2
    iget-object v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mMicBuffer:[B

    return-object v1

    .line 172
    :cond_3
    const/4 v1, -0x2

    if-ne v0, v1, :cond_0

    goto :goto_0
.end method

.method public isRecording()Z
    .locals 2

    .prologue
    .line 271
    iget-object v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mutex:Ljava/lang/Object;

    monitor-enter v1

    .line 272
    :try_start_0
    iget-boolean v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_isRecording:Z

    monitor-exit v1

    return v0

    .line 273
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public run()V
    .locals 7

    .prologue
    .line 44
    iget-object v5, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mutex:Ljava/lang/Object;

    monitor-enter v5

    .line 45
    :goto_0
    :try_start_0
    invoke-virtual {p0}, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->isRecording()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v4

    if-nez v4, :cond_0

    .line 47
    :try_start_1
    iget-object v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mutex:Ljava/lang/Object;

    invoke-virtual {v4}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 48
    :catch_0
    move-exception v0

    .line 49
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_2
    new-instance v4, Ljava/lang/IllegalStateException;

    const-string v6, "Wait interrupted"

    invoke-direct {v4, v6, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v4

    .line 52
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v4

    monitor-exit v5
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v4

    :cond_0
    :try_start_3
    monitor-exit v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 54
    const/16 v4, -0x13

    invoke-static {v4}, Landroid/os/Process;->setThreadPriority(I)V

    .line 55
    iget-object v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;

    if-eqz v4, :cond_3

    .line 60
    :try_start_4
    iget-boolean v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_isEnhancedMicrophone:Z

    if-eqz v4, :cond_2

    .line 66
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v1

    .line 67
    .local v1, "m_Activity":Lcom/adobe/air/AndroidActivityWrapper;
    invoke-virtual {v1}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v4

    const-string v5, "audio"

    invoke-virtual {v4, v5}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/media/AudioManager;

    .line 68
    .local v2, "m_audioManager":Landroid/media/AudioManager;
    const/4 v4, 0x3

    invoke-virtual {v2, v4}, Landroid/media/AudioManager;->setMode(I)V

    .line 75
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v5, 0x10

    if-lt v4, v5, :cond_2

    .line 76
    iget-object v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;

    invoke-virtual {v4}, Landroid/media/AudioRecord;->getAudioSessionId()I

    move-result v3

    .line 77
    .local v3, "sessionId":I
    invoke-static {}, Landroid/media/audiofx/AcousticEchoCanceler;->isAvailable()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-static {}, Landroid/media/audiofx/NoiseSuppressor;->isAvailable()Z

    move-result v4

    if-eqz v4, :cond_4

    .line 78
    const/4 v4, 0x1

    iput-boolean v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->hardwareAEC:Z

    .line 81
    :goto_1
    iget-boolean v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->hardwareAEC:Z

    if-eqz v4, :cond_2

    .line 82
    invoke-static {v3}, Landroid/media/audiofx/AcousticEchoCanceler;->create(I)Landroid/media/audiofx/AcousticEchoCanceler;

    move-result-object v4

    iput-object v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->echoCanceler:Landroid/media/audiofx/AcousticEchoCanceler;

    .line 83
    iget-object v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->echoCanceler:Landroid/media/audiofx/AcousticEchoCanceler;

    if-eqz v4, :cond_1

    .line 84
    iget-object v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->echoCanceler:Landroid/media/audiofx/AcousticEchoCanceler;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Landroid/media/audiofx/AcousticEchoCanceler;->setEnabled(Z)I

    .line 86
    :cond_1
    const-string v4, "AJAudioRecord"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "IS Hardware NoiseSuppressor enabled "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {}, Landroid/media/audiofx/NoiseSuppressor;->isAvailable()Z

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 88
    invoke-static {v3}, Landroid/media/audiofx/NoiseSuppressor;->create(I)Landroid/media/audiofx/NoiseSuppressor;

    move-result-object v4

    iput-object v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->noiseSuppressor:Landroid/media/audiofx/NoiseSuppressor;

    .line 89
    iget-object v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->noiseSuppressor:Landroid/media/audiofx/NoiseSuppressor;

    if-eqz v4, :cond_2

    .line 90
    iget-object v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->noiseSuppressor:Landroid/media/audiofx/NoiseSuppressor;

    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Landroid/media/audiofx/NoiseSuppressor;->setEnabled(Z)I

    .line 95
    .end local v1    # "m_Activity":Lcom/adobe/air/AndroidActivityWrapper;
    .end local v2    # "m_audioManager":Landroid/media/AudioManager;
    .end local v3    # "sessionId":I
    :cond_2
    iget-object v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;

    invoke-virtual {v4}, Landroid/media/AudioRecord;->startRecording()V

    .line 103
    :cond_3
    :goto_2
    return-void

    .line 80
    .restart local v1    # "m_Activity":Lcom/adobe/air/AndroidActivityWrapper;
    .restart local v2    # "m_audioManager":Landroid/media/AudioManager;
    .restart local v3    # "sessionId":I
    :cond_4
    const/4 v4, 0x0

    iput-boolean v4, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->hardwareAEC:Z
    :try_end_4
    .catch Ljava/lang/IllegalStateException; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_1

    .line 98
    .end local v1    # "m_Activity":Lcom/adobe/air/AndroidActivityWrapper;
    .end local v2    # "m_audioManager":Landroid/media/AudioManager;
    .end local v3    # "sessionId":I
    :catch_1
    move-exception v4

    goto :goto_2
.end method

.method public setIsEnhanced(Z)V
    .locals 0
    .param p1, "val"    # Z

    .prologue
    .line 277
    iput-boolean p1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_isEnhancedMicrophone:Z

    .line 278
    return-void
.end method

.method public setRecording(Z)V
    .locals 3
    .param p1, "recording"    # Z

    .prologue
    .line 194
    iget-object v1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mutex:Ljava/lang/Object;

    monitor-enter v1

    .line 195
    :try_start_0
    iput-boolean p1, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_isRecording:Z

    .line 196
    iget-boolean v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_isRecording:Z

    if-eqz v0, :cond_0

    .line 197
    iget-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->mutex:Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Object;->notify()V

    .line 204
    :goto_0
    monitor-exit v1

    .line 205
    return-void

    .line 199
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;

    invoke-virtual {v0}, Landroid/media/AudioRecord;->getState()I

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_1

    .line 200
    iget-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;

    invoke-virtual {v0}, Landroid/media/AudioRecord;->stop()V

    .line 202
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/microphone/AIRMicrophoneRecorder;->m_recorder:Landroid/media/AudioRecord;

    invoke-virtual {v0}, Landroid/media/AudioRecord;->release()V

    goto :goto_0

    .line 204
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

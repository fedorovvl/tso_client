.class public Lcom/adobe/fre/FREByteArray;
.super Lcom/adobe/fre/FREObject;
.source "FREByteArray.java"


# instance fields
.field private m_dataPointer:J


# direct methods
.method protected constructor <init>()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FRETypeMismatchException;,
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREASErrorException;,
            Lcom/adobe/fre/FRENoSuchNameException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    .line 44
    const-string v0, "flash.utils.ByteArray"

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/adobe/fre/FREObject;-><init>(Ljava/lang/String;[Lcom/adobe/fre/FREObject;)V

    .line 45
    return-void
.end method

.method private constructor <init>(Lcom/adobe/fre/FREObject$CFREObjectWrapper;)V
    .locals 0
    .param p1, "obj"    # Lcom/adobe/fre/FREObject$CFREObjectWrapper;

    .prologue
    .line 24
    invoke-direct {p0, p1}, Lcom/adobe/fre/FREObject;-><init>(Lcom/adobe/fre/FREObject$CFREObjectWrapper;)V

    .line 25
    return-void
.end method

.method public static newByteArray()Lcom/adobe/fre/FREByteArray;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREASErrorException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation

    .prologue
    .line 61
    :try_start_0
    new-instance v0, Lcom/adobe/fre/FREByteArray;

    invoke-direct {v0}, Lcom/adobe/fre/FREByteArray;-><init>()V
    :try_end_0
    .catch Lcom/adobe/fre/FRETypeMismatchException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Lcom/adobe/fre/FREInvalidObjectException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/adobe/fre/FRENoSuchNameException; {:try_start_0 .. :try_end_0} :catch_0

    .line 67
    :goto_0
    return-object v0

    .line 65
    :catch_0
    move-exception v0

    .line 67
    :goto_1
    const/4 v0, 0x0

    goto :goto_0

    .line 64
    :catch_1
    move-exception v0

    goto :goto_1

    .line 63
    :catch_2
    move-exception v0

    goto :goto_1
.end method


# virtual methods
.method public native acquire()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native getBytes()Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native getLength()J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native release()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

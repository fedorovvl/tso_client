.class public Lcom/adobe/fre/FREBitmapData;
.super Lcom/adobe/fre/FREObject;
.source "FREBitmapData.java"


# instance fields
.field private m_dataPointer:J


# direct methods
.method private constructor <init>(Lcom/adobe/fre/FREObject$CFREObjectWrapper;)V
    .locals 0
    .param p1, "obj"    # Lcom/adobe/fre/FREObject$CFREObjectWrapper;

    .prologue
    .line 24
    invoke-direct {p0, p1}, Lcom/adobe/fre/FREObject;-><init>(Lcom/adobe/fre/FREObject$CFREObjectWrapper;)V

    .line 25
    return-void
.end method

.method protected constructor <init>([Lcom/adobe/fre/FREObject;)V
    .locals 1
    .param p1, "constructorArgs"    # [Lcom/adobe/fre/FREObject;
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
    const-string v0, "flash.display.BitmapData"

    invoke-direct {p0, v0, p1}, Lcom/adobe/fre/FREObject;-><init>(Ljava/lang/String;[Lcom/adobe/fre/FREObject;)V

    .line 45
    return-void
.end method

.method public static newBitmapData(IIZ[Ljava/lang/Byte;)Lcom/adobe/fre/FREBitmapData;
    .locals 8
    .param p0, "width"    # I
    .param p1, "height"    # I
    .param p2, "transparent"    # Z
    .param p3, "fillColor"    # [Ljava/lang/Byte;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREASErrorException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    const/4 v7, 0x4

    .line 65
    array-length v5, p3

    if-eq v5, v7, :cond_0

    .line 66
    new-instance v5, Ljava/lang/IllegalArgumentException;

    const-string v6, "fillColor has wrong length"

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 67
    :cond_0
    new-array v0, v7, [Lcom/adobe/fre/FREObject;

    .line 68
    .local v0, "array":[Lcom/adobe/fre/FREObject;
    const/4 v5, 0x0

    new-instance v6, Lcom/adobe/fre/FREObject;

    invoke-direct {v6, p0}, Lcom/adobe/fre/FREObject;-><init>(I)V

    aput-object v6, v0, v5

    .line 69
    const/4 v5, 0x1

    new-instance v6, Lcom/adobe/fre/FREObject;

    invoke-direct {v6, p1}, Lcom/adobe/fre/FREObject;-><init>(I)V

    aput-object v6, v0, v5

    .line 70
    const/4 v5, 0x2

    new-instance v6, Lcom/adobe/fre/FREObject;

    invoke-direct {v6, p2}, Lcom/adobe/fre/FREObject;-><init>(Z)V

    aput-object v6, v0, v5

    .line 71
    const/4 v2, 0x0

    .line 72
    .local v2, "color":I
    const/4 v4, -0x1

    .line 73
    .local v4, "signMask":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    if-ge v3, v7, :cond_1

    .line 75
    rsub-int/lit8 v5, v3, 0x3

    mul-int/lit8 v1, v5, 0x8

    .line 77
    .local v1, "cShiftCount":I
    aget-object v5, p3, v3

    invoke-virtual {v5}, Ljava/lang/Byte;->byteValue()B

    move-result v5

    shl-int/2addr v5, v1

    and-int/2addr v5, v4

    or-int/2addr v2, v5

    .line 78
    ushr-int/lit8 v4, v4, 0x8

    .line 73
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 80
    .end local v1    # "cShiftCount":I
    :cond_1
    const/4 v5, 0x3

    new-instance v6, Lcom/adobe/fre/FREObject;

    invoke-direct {v6, v2}, Lcom/adobe/fre/FREObject;-><init>(I)V

    aput-object v6, v0, v5

    .line 84
    :try_start_0
    new-instance v5, Lcom/adobe/fre/FREBitmapData;

    invoke-direct {v5, v0}, Lcom/adobe/fre/FREBitmapData;-><init>([Lcom/adobe/fre/FREObject;)V
    :try_end_0
    .catch Lcom/adobe/fre/FRETypeMismatchException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Lcom/adobe/fre/FREInvalidObjectException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/adobe/fre/FRENoSuchNameException; {:try_start_0 .. :try_end_0} :catch_0

    .line 90
    :goto_1
    return-object v5

    .line 88
    :catch_0
    move-exception v5

    .line 90
    :goto_2
    const/4 v5, 0x0

    goto :goto_1

    .line 87
    :catch_1
    move-exception v5

    goto :goto_2

    .line 86
    :catch_2
    move-exception v5

    goto :goto_2
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

.method public native getBits()Ljava/nio/ByteBuffer;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native getHeight()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native getLineStride32()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native getWidth()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native hasAlpha()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native invalidateRect(IIII)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;,
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation
.end method

.method public native isInvertedY()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native isPremultiplied()Z
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

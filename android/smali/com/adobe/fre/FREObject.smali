.class public Lcom/adobe/fre/FREObject;
.super Ljava/lang/Object;
.source "FREObject.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/fre/FREObject$CFREObjectWrapper;
    }
.end annotation


# instance fields
.field private m_objectPointer:J


# direct methods
.method protected constructor <init>(D)V
    .locals 1
    .param p1, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation

    .prologue
    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    invoke-direct {p0, p1, p2}, Lcom/adobe/fre/FREObject;->FREObjectFromDouble(D)V

    .line 52
    return-void
.end method

.method protected constructor <init>(I)V
    .locals 0
    .param p1, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation

    .prologue
    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    invoke-direct {p0, p1}, Lcom/adobe/fre/FREObject;->FREObjectFromInt(I)V

    .line 47
    return-void
.end method

.method protected constructor <init>(Lcom/adobe/fre/FREObject$CFREObjectWrapper;)V
    .locals 2
    .param p1, "obj"    # Lcom/adobe/fre/FREObject$CFREObjectWrapper;

    .prologue
    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 40
    invoke-static {p1}, Lcom/adobe/fre/FREObject$CFREObjectWrapper;->access$000(Lcom/adobe/fre/FREObject$CFREObjectWrapper;)J

    move-result-wide v0

    iput-wide v0, p0, Lcom/adobe/fre/FREObject;->m_objectPointer:J

    .line 41
    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation

    .prologue
    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 61
    invoke-direct {p0, p1}, Lcom/adobe/fre/FREObject;->FREObjectFromString(Ljava/lang/String;)V

    .line 62
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;[Lcom/adobe/fre/FREObject;)V
    .locals 0
    .param p1, "className"    # Ljava/lang/String;
    .param p2, "constructorArgs"    # [Lcom/adobe/fre/FREObject;
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
    .line 145
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 146
    invoke-direct {p0, p1, p2}, Lcom/adobe/fre/FREObject;->FREObjectFromClass(Ljava/lang/String;[Lcom/adobe/fre/FREObject;)V

    .line 147
    return-void
.end method

.method protected constructor <init>(Z)V
    .locals 0
    .param p1, "value"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation

    .prologue
    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    invoke-direct {p0, p1}, Lcom/adobe/fre/FREObject;->FREObjectFromBoolean(Z)V

    .line 57
    return-void
.end method

.method private native FREObjectFromBoolean(Z)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation
.end method

.method private native FREObjectFromClass(Ljava/lang/String;[Lcom/adobe/fre/FREObject;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FRETypeMismatchException;,
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREASErrorException;,
            Lcom/adobe/fre/FRENoSuchNameException;,
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation
.end method

.method private native FREObjectFromDouble(D)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation
.end method

.method private native FREObjectFromInt(I)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation
.end method

.method private native FREObjectFromString(Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation
.end method

.method public static newObject(D)Lcom/adobe/fre/FREObject;
    .locals 2
    .param p0, "value"    # D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation

    .prologue
    .line 72
    new-instance v0, Lcom/adobe/fre/FREObject;

    invoke-direct {v0, p0, p1}, Lcom/adobe/fre/FREObject;-><init>(D)V

    return-object v0
.end method

.method public static newObject(I)Lcom/adobe/fre/FREObject;
    .locals 1
    .param p0, "value"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation

    .prologue
    .line 67
    new-instance v0, Lcom/adobe/fre/FREObject;

    invoke-direct {v0, p0}, Lcom/adobe/fre/FREObject;-><init>(I)V

    return-object v0
.end method

.method public static newObject(Ljava/lang/String;)Lcom/adobe/fre/FREObject;
    .locals 1
    .param p0, "value"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation

    .prologue
    .line 82
    new-instance v0, Lcom/adobe/fre/FREObject;

    invoke-direct {v0, p0}, Lcom/adobe/fre/FREObject;-><init>(Ljava/lang/String;)V

    return-object v0
.end method

.method public static native newObject(Ljava/lang/String;[Lcom/adobe/fre/FREObject;)Lcom/adobe/fre/FREObject;
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
.end method

.method public static newObject(Z)Lcom/adobe/fre/FREObject;
    .locals 1
    .param p0, "value"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;
        }
    .end annotation

    .prologue
    .line 77
    new-instance v0, Lcom/adobe/fre/FREObject;

    invoke-direct {v0, p0}, Lcom/adobe/fre/FREObject;-><init>(Z)V

    return-object v0
.end method


# virtual methods
.method public native callMethod(Ljava/lang/String;[Lcom/adobe/fre/FREObject;)Lcom/adobe/fre/FREObject;
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
.end method

.method public native getAsBool()Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FRETypeMismatchException;,
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native getAsDouble()D
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FRETypeMismatchException;,
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native getAsInt()I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FRETypeMismatchException;,
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native getAsString()Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FRETypeMismatchException;,
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native getProperty(Ljava/lang/String;)Lcom/adobe/fre/FREObject;
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
.end method

.method public native setProperty(Ljava/lang/String;Lcom/adobe/fre/FREObject;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FRETypeMismatchException;,
            Lcom/adobe/fre/FREInvalidObjectException;,
            Lcom/adobe/fre/FREASErrorException;,
            Lcom/adobe/fre/FRENoSuchNameException;,
            Lcom/adobe/fre/FREReadOnlyException;,
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

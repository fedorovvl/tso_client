.class public final enum Lcom/adobe/air/FlashEGLFactory$FlashEGLType;
.super Ljava/lang/Enum;
.source "FlashEGLFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/FlashEGLFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "FlashEGLType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/FlashEGLFactory$FlashEGLType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

.field public static final enum FLASHEGL10:Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

.field public static final enum FLASHEGL14:Lcom/adobe/air/FlashEGLFactory$FlashEGLType;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 19
    new-instance v0, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    const-string v1, "FLASHEGL10"

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;->FLASHEGL10:Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    new-instance v0, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    const-string v1, "FLASHEGL14"

    invoke-direct {v0, v1, v3}, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;->FLASHEGL14:Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    const/4 v0, 0x2

    new-array v0, v0, [Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    sget-object v1, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;->FLASHEGL10:Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    aput-object v1, v0, v2

    sget-object v1, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;->FLASHEGL14:Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    aput-object v1, v0, v3

    sput-object v0, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;->$VALUES:[Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 19
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/FlashEGLFactory$FlashEGLType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 19
    const-class v0, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/FlashEGLFactory$FlashEGLType;
    .locals 1

    .prologue
    .line 19
    sget-object v0, Lcom/adobe/air/FlashEGLFactory$FlashEGLType;->$VALUES:[Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    invoke-virtual {v0}, [Lcom/adobe/air/FlashEGLFactory$FlashEGLType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/FlashEGLFactory$FlashEGLType;

    return-object v0
.end method

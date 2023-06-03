.class final enum Lcom/adobe/flashplayer/HDMIUtils$HDMIState;
.super Ljava/lang/Enum;
.source "HDMIUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/flashplayer/HDMIUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "HDMIState"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/flashplayer/HDMIUtils$HDMIState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

.field public static final enum HDCPON:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

.field public static final enum OFF:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

.field public static final enum ON:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

.field public static final enum UNKNOWN:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;


# instance fields
.field public final value:I


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 34
    new-instance v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    const-string v1, "UNKNOWN"

    invoke-direct {v0, v1, v2, v2}, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->UNKNOWN:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    .line 35
    new-instance v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    const-string v1, "OFF"

    invoke-direct {v0, v1, v3, v3}, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->OFF:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    .line 36
    new-instance v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    const-string v1, "ON"

    invoke-direct {v0, v1, v4, v4}, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->ON:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    .line 37
    new-instance v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    const-string v1, "HDCPON"

    invoke-direct {v0, v1, v5, v5}, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->HDCPON:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    .line 32
    const/4 v0, 0x4

    new-array v0, v0, [Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    sget-object v1, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->UNKNOWN:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    aput-object v1, v0, v2

    sget-object v1, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->OFF:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    aput-object v1, v0, v3

    sget-object v1, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->ON:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    aput-object v1, v0, v4

    sget-object v1, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->HDCPON:Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    aput-object v1, v0, v5

    sput-object v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->$VALUES:[Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .param p3, "v"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .prologue
    .line 41
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 42
    iput p3, p0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->value:I

    .line 43
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/flashplayer/HDMIUtils$HDMIState;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 32
    const-class v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    return-object v0
.end method

.method public static values()[Lcom/adobe/flashplayer/HDMIUtils$HDMIState;
    .locals 1

    .prologue
    .line 32
    sget-object v0, Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->$VALUES:[Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    invoke-virtual {v0}, [Lcom/adobe/flashplayer/HDMIUtils$HDMIState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/flashplayer/HDMIUtils$HDMIState;

    return-object v0
.end method
